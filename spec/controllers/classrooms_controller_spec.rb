require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  describe "#index" do
    let(:classrooms) { create_list(:classroom, 5) }
    let(:lesson_id) { classrooms.first.lesson_id }

    subject { get :index, params: { lesson_id: classrooms.first.lesson_id } }
    context "when not logged in" do
      it 'cannot get all the classrooms' do
        subject
        expect(json_response[:errors][0]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in" do
      it 'can get all the classrooms' do
        auth_me_please
        subject
        expect(json_response[:classrooms].length).to eq(Classroom.count)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#show" do
    let(:classroom) { create(:classroom) }
    let(:id) { classroom.id }
    let(:lesson_id) { classroom.lesson_id }

    subject { get :show, params: { id: id, lesson_id: lesson_id } }

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
      it 'can get the classroom' do
        expect(json_response[:classroom][:title]).to eq(classroom.title)
        expect(json_response[:classroom][:description]).to eq(classroom.description)
        expect(response).to have_http_status(200)
      end

      context "when ressource is not found" do
        let(:id) { "79cfcc41-edcb-4f5f-91c9-3fb9b3733509" }
        it 'respond with not found and message error' do
          expect(response).to have_http_status(404)
          expect(json_response[:errors][0][:detail]).to eq("Couldn't find Classroom with 'id'=79cfcc41-edcb-4f5f-91c9-3fb9b3733509")
        end
      end
    end
  end

  describe "#create" do
    let(:title) { Faker::ChuckNorris.fact[0..49] }
    let(:description) { Faker::TwinPeaks.quote }
    let(:lesson) { create(:lesson) }
    let(:lesson_id) { lesson.id }

    subject { post :create, params: { classroom: { title: title, description: description }, lesson_id: lesson_id } }

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
      it 'can create the classroom and set current user as creator' do
        expect{ subject }.to change(Classroom, :count).from(0).to(1)
        first_classroom = Classroom.first
        expect(json_response[:classroom][:title]).to eq(first_classroom.title)
        expect(json_response[:classroom][:description]).to eq(first_classroom.description)
        expect(json_response[:classroom][:lesson_id]).to eq(first_classroom.lesson_id)
        expect(response).to have_http_status(201)
      end
      it 'the creator of the lesson is the teacher of the classroom' do
        subject
        first_classroom = Classroom.first
        expect(first_classroom.teacher).to eq(lesson.creator)
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
    let(:classroom) { create(:classroom) }
    let(:id) { classroom.id }
    let(:title) { Faker::ChuckNorris.fact[0..49] }
    let(:description) { Faker::TwinPeaks.quote }
    let(:lesson) { classroom.lesson }
    let(:lesson_id) { classroom.id }

    subject { patch :update, params: { id: id, classroom: params, lesson_id: lesson_id } }
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
      it 'can update a classroom' do
        auth_me_please_as_creator(lesson)
        subject
        first_classroom = Classroom.first
        expect(json_response[:classroom][:title]).to eq(first_classroom.title)
        expect(json_response[:classroom][:description]).to eq(first_classroom.description)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#delete" do
    let!(:classroom) { create(:classroom) }
    let(:user) { create(:user) }
    let(:id) { classroom.id }
    let(:lesson) { classroom.lesson }
    let(:lesson_id) { classroom.id }

    subject { delete :destroy, params: { id: id, lesson_id: lesson_id } }

    context "when logged in" do
      it 'cannot delete a classroom' do
        auth_me_please
        subject
        expect(json_response[:errors]).to eq("You are not authorized to perform this action.")
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in as creator" do
      it 'can delete a classroom' do
        auth_me_please_as_creator(lesson)
        subject
        expect(response).to have_http_status(204)
      end
    end
  end
end
