class StepsController < ApplicationController
  before_action :authenticate_user!

  def show
    step = invitation.find(params[:id])
    render json: step
  end

  def index
    steps = invitation.all
    render json: steps
  end

  def create
    authorize current_step
    step = invitation.new(create_params.merge(lesson: current_lesson))
    step.save!
    render json: step, status: :created
  end

  def update
    authorize current_step
    current_lesson.update!(update_params)
    render json: current_lesson
  end

  def destroy
    authorize current_step
    current_step.destroy
    head :no_content
  end

  private

  def current_step
    @current_step ||= invitation.find(params[:id])
  end

  def current_lesson
    @current_lesson ||= Lesson.find(params[:lesson_id])
  end

  def create_params
    params.require(:step).permit(:title, :description)
  end

  alias_method :update_params, :create_params
end
