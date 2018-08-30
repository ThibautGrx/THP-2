require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'invitation_email' do
    let(:invitation){ create(:invitation) }
    let(:student){ invitation.student }
    let(:classroom){ invitation.classroom }
    let(:lesson){ classroom.lesson }
    let(:mail) { UserMailer.invitation_email(invitation) }

    it 'renders the subject' do
      expect(mail.subject).to eq('You\'ve received an invitation !')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([student.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['contact@thp2.com'])
    end

    it 'countain username' do
      expect(mail.body.encoded).to match(student.username)
    end

    it 'countain classroom name' do
      expect(mail.body.encoded).to match(classroom.title)
    end

    it 'countain url to accepte invitation' do
      expect(mail.body.encoded).to match("/invitations/#{invitation.id}")
    end
  end
end
