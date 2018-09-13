class StepsController < ApplicationController
  before_action :authenticate_user!

  def show
    step = Step.find(params[:id])
    render json: step
  end

  def index
    steps = Step.all
    render json: steps
  end

  def create
    authorize(current_lesson, :create_step?)
    step = Step.new(create_params.merge(lesson: current_lesson))
    step.save!
    render json: step, status: :created
  end

  def update
    authorize current_step
    current_step.update!(update_params)
    render json: current_step
  end

  def destroy
    authorize current_step
    current_step.destroy
    head :no_content
  end

  private

  def current_step
    @current_step ||= Step.find(params[:id])
  end

  def current_lesson
    @current_lesson ||= Lesson.find(params[:lesson_id])
  end

  def create_params
    params.require(:step).permit(:title, :description)
  end

  alias_method :update_params, :create_params
end
