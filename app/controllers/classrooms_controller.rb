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
    classroom = Classroom.create!(create_params.merge(lesson_id: params[:lesson_id]))
    render json: classroom, status: :created
  end

  def update
    classroom = Classroom.find(params[:id])
    authorize classroom
    classroom.update!(update_params)
    render json: classroom
  end

  def destroy
    authorize Classroom.find(params[:id]).delete
    head :no_content
  end

  private

  def create_params
    params.require(:classroom).permit(:title, :description )
  end
  alias_method :update_params, :create_params
end
