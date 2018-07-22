require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  #   describe "POST create" do
  #     let(:title) { Faker::Beer.name }
  #     let(:description) { Faker::ChuckNorris.fact }
  #
  #     before do
  #       auth_me_please
  #     end
  #
  #     subject { post(:create, params: { lesson: params }) }
  #     let(:params) do
  #       {
  #         title: title,
  #         description: description
  #       }
  #     end
  #     context 'lesson is valid' do
  #       it "create the lesson " do
  #         expect{ subject }.to change(Lesson, :count).by(1)
  #         expect(json_response[:lesson][:title]).to eq(title)
  #         expect(json_response[:lesson][:description]).to eq(description)
  #         expect(json_response[:lesson][:creator]).to eq(test_user.as_json)
  #         first_lesson = Lesson.first
  #         expect(first_lesson.title).to eq(title)
  #         expect(first_lesson.description).to eq(description)
  #         expect(first_lesson.creator).to eq(test_user)
  #         expect(response.status).to eq(201)
  #       end
  #     end
  #
  #     context 'title and descritpion are not  valid' do
  #       let(:title) { nil }
  #       let(:description) { nil }
  #       it "fails because title&description = nil" do
  #         expect{ subject }.not_to(change(Lesson, :count))
  #         expect(response.status).to eq(403)
  #         expect(json_response[:errors][0]).to eq("Title can't be blank")
  #         expect(json_response[:errors][1]).to eq("Description can't be blank")
  #       end
  #     end
  #
  #     context 'title and descritpion are not  valid' do
  #       let(:title) { 'a' * 51 }
  #       let(:description) { 'a' * 301 }
  #       it "fails because title&description are too long" do
  #         expect{ subject }.not_to(change(Lesson, :count))
  #         expect(response.status).to eq(403)
  #         expect(json_response[:errors][0]).to eq("Title is too long (maximum is 50 characters)")
  #         expect(json_response[:errors][1]).to eq("Description is too long (maximum is 300 characters)")
  #       end
  #     end
  #   end
  #
  #   describe "POST create" do
  #     before do
  #       auth_me_please
  #     end
  #
  #     subject { post(:create, params: {}) }
  #
  #     context 'it miss params' do
  #       it "fails because title&description = nil" do
  #         expect{ subject }.not_to(change(Lesson, :count))
  #         expect(response.status).to eq(403)
  #         expect(json_response[:errors][0]).to eq("param is missing or the value is empty: lesson")
  #       end
  #     end
  #   end
  #
  #   describe "GET show" do
  #     let(:lesson) { create(:lesson) }
  #     let(:id) { lesson.id }
  #
  #     before do
  #       auth_me_please
  #     end
  #
  #     subject { get :show, params: { id: id } }
  #
  #     it "renders the lesson" do
  #       subject
  #       expect(json_response[:lesson][:id]).to eq(lesson.id)
  #       expect(json_response[:lesson][:title]).to eq(lesson.title)
  #       expect(json_response[:lesson][:description]).to eq(lesson.description)
  #       expect(response.status).to eq(200)
  #     end
  #
  #     context "the lesson doesn't exist" do
  #       let(:id) { "79cfcc41-edcb-4f5f-91c9-3fb9b3733509" }
  #       it "return not found" do
  #         subject
  #         expect(response.status).to eq(404)
  #       end
  #     end
  #   end
  #
  #   describe "PATCH update" do
  #     let!(:lesson) { create(:lesson) }
  #     let(:id) { lesson.id }
  #     let(:title) { Faker::Beer.name }
  #     let(:description) { Faker::ChuckNorris.fact }
  #
  #     before do
  #       auth_me_please
  #     end
  #
  #     subject { patch(:update, params: { id: id, lesson: params }) }
  #     let(:params) do
  #       {
  #         title: title,
  #         description: description
  #       }
  #     end
  #
  #     context 'lesson is valid' do
  #       it "update the lesson " do
  #         expect{ subject }.to change{ lesson.reload.title }.to(title)
  #         expect(json_response[:lesson][:title]).to eq(title)
  #         first_lesson = Lesson.first
  #         expect(first_lesson.title).to eq(title)
  #         expect(response.status).to eq(200)
  #       end
  #       it "update the lesson " do
  #         expect{ subject }.to change{ lesson.reload.description }.to(description)
  #         expect(json_response[:lesson][:description]).to eq(description)
  #         first_lesson = Lesson.first
  #         expect(first_lesson.description).to eq(description)
  #         expect(response.status).to eq(200)
  #       end
  #     end
  #   end
  #
  #   describe "GET #index" do
  #     let!(:lessons) { create_list(:lesson, 10) }
  #
  #     before do
  #       auth_me_please
  #     end
  #
  #     subject do
  #       get :index
  #     end
  #
  #     it "returns all the turtles" do
  #       subject
  #       expect(json_response[:lessons].size).to eq(10)
  #     end
  #   end
  #
  #   describe "DELETE #destroy" do
  #     let!(:lesson) { create(:lesson) }
  #     let(:id) { lesson.id }
  #
  #     before do
  #       auth_me_please
  #     end
  #
  #     subject do
  #       delete :destroy, params: { id: id }
  #     end
  #
  #     it "delete the turtle" do
  #       expect{ subject }.to change(Lesson, :count).from(1).to(0)
  #     end
  #
  #     it "return 204" do
  #       subject
  #       expect(response.status).to eq(204)
  #     end
  #
  #     context 'lesson doesn\'t exist' do
  #       let(:id) { "79cfcc41-edcb-4f5f-91c9-3fb9b3733509" }
  #       it 'return not found' do
  #         subject
  #         expect(response.status).to eq(404)
  #       end
  #     end
  #   end
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
      it 'respond with 401 and error message' do
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
        it 'respond with 404 and message error' do
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
      it 'respond with 401 and error message' do
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
      it 'respond with 401 and error message' do
        auth_me_please
        p lesson.creator.id
        p controller.current_user.id
        subject
        p json_response
      end
    end

    context "when logged in as creator" do
      it 'can update a lesson' do
        auth_me_please_as_creator(lesson)
        subject
      end
    end
  end

  describe "#delete" do
    context "when not logged in" do
      it 'cannot delete a lesson'
    end

    context "when logged in" do
      it 'cannot delete a lesson'
    end

    context "when logged in as creator" do
      it 'can delete a lesson'
    end
  end
end
