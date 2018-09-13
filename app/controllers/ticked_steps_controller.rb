class TickedStepsController < ApplicationController
  before_action :authenticate_user!

  def index
    ticked_steps = TickedStep.all
    render json: ticked_steps
  end

  def create
    ticked_step = current_user.ticked_steps.new(classroom: current_classroom, step: current_step )
    ticked_step.save!
    render json: ticked_step, status: :created
  end

  def destroy
    current_ticked_step.destroy
    head :no_content
  end

  private

  def current_ticked_step
    @current_ticked_step ||= TickedStep.find(params[:id])
  end

  def current_step
    @current_step ||= Step.find(params[:step_id])
  end

  def current_classroom
    @current_classroom ||= Classroom.find(params[:classroom_id])
  end
end
