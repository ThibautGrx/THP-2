class UserMailer < ApplicationMailer
  default from: 'contact@thp2.com'

  def invitation_email(classroom, invitation)
    @student = invitation.student
    @teacher = invitation.teacher
    @classroom = classroom
    @invitation = invitation
    mail(to: @student.email, subject: 'You\'ve received an invitation !')
  end
end
