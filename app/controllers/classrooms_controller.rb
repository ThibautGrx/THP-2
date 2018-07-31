class ClassroomsController < ApplicationController
  before_action :authenticate_user!

  def show
    classroom = Classroom.find(params[:id])
    render json: classroom
  end

  def index
    classrooms = Classroom.all
    render json: classrooms
  end

  def create
    classroom = current_user.classrooms.create!(create_params.merge(lesson: current_lesson))
    render json: classroom, status: :created
  end

  def update
    authorize current_classroom
    current_classroom.update!(update_params)
    render json: current_classroom
  end

  def destroy
    authorize current_classroom
    current_classroom.destroy
    head :no_content
  end

  private

  def current_classroom
    @current_classroom ||= Classroom.find(params[:id])
  end

  def current_lesson
    @current_lesson ||= Lesson.find(params[:lesson_id])
  end

  def create_params
    params.require(:classroom).permit(:title, :description)
  end
  alias_method :update_params, :create_params
end
