class LessonsController < ApplicationController
  before_action :authenticate_user!

  def show
    lesson = Lesson.find(params[:id])
    render json: lesson
  end

  def index
    lessons = Lesson.all
    render json: lessons
  end

  def create
    lesson = Lesson.create!(create_params)
    render json: lesson, status: :created
  end

  def update
    lesson = Lesson.find(params[:id])
    lesson.update!(update_params)
    render json: lesson
  end

  def destroy
    Lesson.find(params[:id]).delete
    head :no_content
  end

  private

  def create_params
    params.require(:lesson).permit(:title, :description, :user_id)
  end
  alias_method :update_params, :create_params
end
