class UserMailer < ApplicationMailer
  def invitation_email(invitation)
    @invitation = invitation
    @student = invitation.student
    @teacher = invitation.teacher
    @classroom = invitation.classroom
    mail(to: @student.email, subject: 'You\'ve received an invitation !')
  end
end
