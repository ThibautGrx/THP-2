class LessonsController < ApplicationController
  # before_action :authenticate_user!

  def show
    lesson = Lesson.find(params[:id])
    render json: lesson
  end

  def index
    lessons = Lesson.all
    render json: lessons
  end

  def create
    lesson = Lesson.create!(create_params.merge(creator: current_user))
    render json: lesson, status: :created
  end

  def update
    authorize current_lesson
    current_lesson.update!(update_params)
    render json: current_lesson
  end

  def destroy
    authorize current_lesson
    current_lesson.destroy
    head :no_content
  end

  private

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def create_params
    params.require(:lesson).permit(:title, :description)
  end
  alias_method :update_params, :create_params
end
