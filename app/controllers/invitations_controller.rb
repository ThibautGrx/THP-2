class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def show
    invitation = Invitation.find(params[:id])
    render json: invitation
  end

  def index
    invitations = Invitation.all
    render json: invitations
  end

  def create
    invitation = Invitation.new(create_params.merge(classroom: current_classroom))
    authorize invitation
    invitation.save!
    render json: invitation, status: :created
  end

  def update
    authorize current_invitation
    current_invitation.accepted = !current_invitation.accepted
    current_invitation.save!
    render json: current_invitation
  end

  def destroy
    authorize current_invitation
    current_invitation.destroy
    head :no_content
  end

  private

  def current_invitation
    @current_invitation ||= Invitation.find(params[:id])
  end

  def current_classroom
    @current_classroom ||= Classroom.find(params[:classroom_id])
  end

  def create_params
    params.require(:invitation).permit(:user_id)
  end
end
