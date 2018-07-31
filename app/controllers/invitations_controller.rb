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
    invitation = Invitations.create!(create_params.merge(classroom: current_classroom))
    render json: invitation, status: :created
  end

  def update
    authorize current_invitation
    current_invitation.update!(update_params)
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
  alias_method :update_params, :create_params
end
