class UserMailer < ApplicationMailer
  default from: 'contact@thp2.com'

  def invitation_email(classroom, invitation)
    @user = invitation.user
    @classroom = classroom
    @invitation = invitation
    mail(to: @user.email, subject: 'You\'ve received an invitation !')
  end
end
