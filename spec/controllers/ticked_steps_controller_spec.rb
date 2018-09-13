require 'rails_helper'

RSpec.describe TickedStepsController, type: :controller do
  let!(:lesson) { create(:lesson, creator: user) }
  let!(:classroom) { create(:classroom, creator: user, lesson: lesson) }
  let!(:step) { create(:step, lesson: lesson) }
  let(:user) { test_user }
  let(:classroom_id) { classroom.id }

  describe "#index" do
    subject { get :index, params: { classroom_id: classroom.id } }

    context "when not logged in" do
      it 'cannot get all the ticked_steps' do
        subject
        expect(json_response[:errors][0]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in" do
      before do
        auth_me_please
      end

      let!(:ticked_steps) { create_list(:ticked_step, 10) }

      it 'can get all the ticked_steps' do
        subject
        expect(json_response[:ticked_steps].length).to eq(10)
      end

      it "returns a 200" do
        subject
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#create" do
    subject { post :create, params: { classroom_id: classroom.id, step_id: step.id } }

    context "the user is not logged in" do
      it "fails with a 401" do
        subject
        expect(response).to have_http_status(401)
      end
    end

    context "the user is logged" do
      before do
        auth_me_please
      end

      it "returns a 201" do
        subject
        expect(response).to have_http_status(201)
      end

      it "returns the new ticked_step" do
        subject
        expect(json_response[:ticked_step][:id]).not_to be_blank
        expect(json_response[:ticked_step][:step_id]).to eq(step.id)
        expect(json_response[:ticked_step][:user_id]).to eq(test_user.id)
        expect(json_response[:ticked_step][:classroom_id]).to eq(classroom.id)
      end

      it "creates the ticked_step" do
        expect{ subject }.to change(TickedStep, :count).by(1)
      end
    end
  end

  describe "#delete" do
    subject { delete :destroy, params: { id: id } }

    let!(:ticked_step) { create(:ticked_step) }
    let(:id) { ticked_step.id }
    let(:user) { test_user }

    context "user is not logged in" do
      it 'cannot delete a ticked_step' do
        subject
        expect(json_response[:errors][0]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to have_http_status(401)
      end
    end

    context "user is logged in" do
      before do
        auth_me_please
      end

      context "the id doesn't exist" do
        let(:id) { Faker::Lorem.word }
        it "returns a 404" do
          subject
          expect(response).to have_http_status(404)
        end
      end

      context "the id exist" do
        it "return no content" do
          subject
          expect(response).to have_http_status(204)
        end
        it "delete the ticked_step" do
          subject
          expect(response).to have_http_status(204)
        end
      end
    end
  end
end
