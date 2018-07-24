require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  describe "#index" do
    let(:lessons) { create_list(:lesson, 5) }

    subject { get :index }

    context "when not logged in" do
      it 'cannot get all the lessons' do
        subject
        expect(json_response[:errors][0]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in" do
      it 'can get all the lessons' do
        auth_me_please
        subject
        expect(json_response[:lessons].length).to eq(Lesson.count)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#show" do
    let(:lesson) { create(:lesson) }
    let(:id) { lesson.id }

    subject { get :show, params: { id: id } }

    context "when not logged in" do
      it 'respond with unauthorized and error message' do
        subject
        expect(json_response[:errors][0]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in" do
      before(:each) do
        auth_me_please
        subject
      end
      it 'can get the lesson' do
        expect(json_response[:lesson][:title]).to eq(lesson.title)
        expect(json_response[:lesson][:description]).to eq(lesson.description)
        expect(response).to have_http_status(200)
      end

      context "when ressource is not found" do
        let(:id) { "79cfcc41-edcb-4f5f-91c9-3fb9b3733509" }
        it 'respond with not found and message error' do
          expect(response).to have_http_status(404)
          expect(json_response[:errors][0][:detail]).to eq("Couldn't find Lesson with 'id'=79cfcc41-edcb-4f5f-91c9-3fb9b3733509")
        end
      end
    end
  end

  describe "#create" do
    let(:title) { Faker::ChuckNorris.fact[0..49] }
    let(:description) { Faker::TwinPeaks.quote }

    subject { post :create, params: { lesson: { title: title, description: description } } }

    context "when not logged in" do
      it 'respond with unauthorized and error message' do
        subject
        expect(json_response[:errors][0]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in" do
      before(:each) do
        auth_me_please
      end
      it 'can create the lesson and set current user as creator' do
        expect{ subject }.to change(Lesson, :count).from(0).to(1)
        first_lesson = Lesson.first
        expect(json_response[:lesson][:title]).to eq(first_lesson.title)
        expect(json_response[:lesson][:description]).to eq(first_lesson.description)
        expect(json_response[:lesson][:creator][:id]).to eq(controller.current_user.id)
        expect(response).to have_http_status(201)
      end

      context "the description is not valid" do
        let(:title) { "" }
        it 'respond with status forbidden and error message' do
          subject
          expect(json_response[:errors][0]).to eq("Title can't be blank")
          expect(response).to have_http_status(403)
        end
      end
      context "the title is not valid" do
        let(:description) { "" }
        it 'respond with status forbidden and error message' do
          subject
          expect(json_response[:errors][0]).to eq("Description can't be blank")
          expect(response).to have_http_status(403)
        end
      end
    end
  end

  describe "#update" do
    let(:lesson) { create(:lesson) }
    let(:id) { lesson.id }
    let(:title) { Faker::ChuckNorris.fact[0..49] }
    let(:description) { Faker::TwinPeaks.quote }

    subject { patch :update, params: { id: id, lesson: params } }
    let(:params) { { title: title, description: description } }

    context "when logged in" do
      it 'respond with unauthorized and error message' do
        auth_me_please
        subject
        expect(json_response[:errors]).to eq("You are not authorized to perform this action.")
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in as creator" do
      it 'can update a lesson' do
        auth_me_please_as_creator(lesson)
        subject
        first_lesson = Lesson.first
        expect(json_response[:lesson][:title]).to eq(first_lesson.title)
        expect(json_response[:lesson][:description]).to eq(first_lesson.description)
        expect(json_response[:lesson][:creator][:id]).to eq(controller.current_user.id)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#delete" do
    let!(:lesson) { create(:lesson) }
    let(:user) { create(:user) }
    let(:id) { lesson.id }
    subject { delete :destroy, params: { id: id } }

    context "when logged in" do
      it 'cannot delete a lesson' do
        auth_me_please
        subject
        expect(json_response[:errors]).to eq("You are not authorized to perform this action.")
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in as creator" do
      it 'can delete a lesson' do
        auth_me_please_as_creator(lesson)
        subject
        expect(response).to have_http_status(204)
      end
    end
  end
end
