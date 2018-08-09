require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  let!(:classroom) { create(:classroom) }
  let!(:lesson) { create(:lesson) }

  describe "#index" do
    subject { get :index, params: { classroom_id: classroom.id, lesson_id: lesson.id } }

    context 'user is not logged in ' do
      it 'return 401 unauthorized' do
        subject
        expect(response).to have_http_status(401)
      end
    end

    context 'user is logged in ' do
      before { auth_me_please }
      let!(:invitations) { create_list(:invitation, 5 ) }

      it 'return invitations' do
        subject
        expect(json_response[:invitations].length).to eq(5)
      end
      it 'respond with 200' do
        subject
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#show" do
    subject { get :show, params: { id: id, classroom_id: classroom.id, lesson_id: lesson.id } }
    let(:invitation) { create(:invitation) }
    let(:id) { invitation.id }

    context 'user is not logged in ' do
      it 'return 401 unauthorized' do
        subject
        expect(response).to have_http_status(401)
      end
    end

    context 'user is logged in ' do
      before { auth_me_please }

      context 'the id doesn\'t exist' do
        let(:id) { Faker::Lorem.word }

        it 'return 404' do
          subject
          expect(response).to have_http_status(404)
        end
      end
      context 'the id exists' do
        it 'return invitation' do
          subject
          expect(json_response[:invitation][:id]).to eq(invitation.id)
          expect(json_response[:invitation][:accepted]).to eq(invitation.accepted)
          expect(json_response[:invitation][:classroom_id]).to eq(invitation.classroom.id)
          expect(json_response[:invitation][:user_id]).to eq(invitation.user.id)
        end
        it 'respond with 200' do
          subject
          expect(response).to have_http_status(200)
        end
      end
    end
  end

  describe "#create" do
    subject { post :create, params: { classroom_id: classroom.id, lesson_id: lesson.id, invitation: invitation_params } }
    let(:invitation_params) { { user_id: user.id } }
    let(:user) { create(:user) }
    let(:teacher) { classroom.creator }

    context 'user is not logged in ' do
      it 'return 401 unauthorized' do
        subject
        expect(response).to have_http_status(401)
      end
    end

    context 'user is logged in ' do
      context 'if logged in as teacher' do
        before { auth_me_please_as(teacher) }
        it 'return the invitation ' do
          subject
          expect(json_response[:invitation][:id]).not_to be_blank
          expect(json_response[:invitation][:user_id]).to eq(user.id)
          expect(json_response[:invitation][:classroom_id]).to eq(classroom.id)
        end
        it 'return 201 ' do
          subject
          expect(response).to have_http_status(201)
        end
        it 'set accepted to false' do
          subject
          expect(json_response[:invitation][:accepted]).to be_falsey
        end
        it 'send an email' do
          expect{ subject }.to change{ ActionMailer::Base.deliveries.count }.by(1)
        end
      end

      context 'if not logged in as teacher' do
        it 'respond with 401 unauthorized' do
          auth_me_please
          subject
          expect(response).to have_http_status(401)
        end
      end
    end
  end

  describe "#update" do
    subject { patch :update, params: { classroom_id: classroom.id, lesson_id: lesson.id, id: id } }
    let!(:invitation) { create(:invitation, user: user ) }
    let(:user) { test_user }
    let(:id) { invitation.id }

    context 'user is not logged in ' do
      it 'return 401 unauthorized' do
        subject
        expect(response).to have_http_status(401)
      end
    end

    context 'user is logged in ' do
      before { auth_me_please }
      context 'if logged in as the invitee' do
        it 'return the invitation ' do
          subject
          expect(json_response[:invitation][:id]).not_to be_blank
          expect(json_response[:invitation][:user_id]).to eq(invitation.user.id)
          expect(json_response[:invitation][:classroom_id]).to eq(invitation.classroom.id)
        end
        it 'return 200 ' do
          subject
          expect(response).to have_http_status(200)
        end
        it 'set accepted to true' do
          subject
          expect(json_response[:invitation][:accepted]).to be_truthy
        end
      end

      context 'if not logged in as an invitee' do
        let(:user) { create(:user) }
        it 'respond with 401 unauthorized' do
          auth_me_please
          subject
          expect(response).to have_http_status(401)
        end
      end
    end
  end

  describe "#delete" do
    subject { delete :destroy, params: { id: id, lesson_id: lesson.id, classroom_id: classroom.id } }

    let!(:invitation) { create(:invitation, user: invitee) }
    let(:id) { invitation.id }
    let(:invitee) { test_user }
    let(:user) { invitation.classroom.creator }

    context "user is not logged in" do
      it 'cannot delete a classroom' do
        subject
        expect(json_response[:errors][0]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to have_http_status(401)
      end
    end

    context "user is logged in" do
      before do
        auth_me_please_as(user)
      end

      context "the id doesn't exist" do
        let(:id) { Faker::Lorem.word }
        it "returns a 404" do
          subject
          expect(response).to have_http_status(404)
        end
      end
      context "the id exist" do
        context 'logged as a teacher ' do
          it "can delete the invitation" do
            subject
            expect(response).to have_http_status(204)
          end
        end
        context 'logged as a invitee ' do
          let(:user) { invitee }
          it "can delete the classroom invitation" do
            subject
            expect(response).to have_http_status(204)
          end
        end
        context 'logged as a random user ' do
          let(:user) { create(:user) }
          it "can delete the classroom" do
            subject
            expect(response).to have_http_status(401)
          end
        end
      end
    end
  end
end
