require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  let!(:lesson) { create(:lesson, creator: test_user) }
  let(:lesson_id) { lesson.id }
  describe "#index" do
    subject { get :index, params: { lesson_id: lesson_id } }

    context "when not logged in" do
      it 'cannot get all the classrooms' do
        subject
        expect(json_response[:errors][0]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in" do
      before do
        auth_me_please
      end

      let(:classrooms) { create_list(:classroom, 5) }

      it 'can get all the classrooms' do
        subject
        expect(json_response[:classrooms].length).to eq(Classroom.count)
      end

      it "returns a 200" do
        subject
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#show" do
    subject { get :show, params: { id: id, lesson_id: lesson_id } }

    let(:classroom) { create(:classroom, lesson: lesson) }
    let(:id) { classroom.id }

    context "when not logged in" do
      it 'respond with unauthorized and error message' do
        subject
        expect(json_response[:errors][0]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in" do
      before do
        auth_me_please
      end
      context "the id exist" do
        it 'returns the classroom' do
          subject
          expect(json_response[:classroom][:id]).to eq(classroom.id)
          expect(json_response[:classroom][:title]).to eq(classroom.title)
          expect(json_response[:classroom][:description]).to eq(classroom.description)
          expect(json_response[:classroom][:creator_id]).to eq(classroom.creator_id)
          expect(json_response[:classroom][:lesson_id]).to eq(classroom.lesson_id)
        end
        it "returns a 200" do
          subject
          expect(response).to have_http_status(200)
        end
      end
      context "the id doesn't exist" do
        let(:id) { Faker::Lorem.word }
        it 'respond with not found and message error' do
          subject
          expect(response).to have_http_status(404)
          expect(json_response[:errors][0][:detail]).to eq("Couldn't find Classroom with 'id'=#{id}")
        end
      end
    end
  end

  describe "#create" do
    subject { post :create, params: { lesson_id: lesson_id, classroom: { title: title, description: description } } }

    let(:title) { Faker::ChuckNorris.fact[0..49] }
    let(:description) { Faker::TwinPeaks.quote }
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

      context "the lesson is not his" do
        let(:lesson) { create(:lesson) }
        let(:lesson_id) { lesson.id }

        it 'can\'t create a classroom' do
          subject
          expect(response).to have_http_status(401)
        end
      end

      it "returns a 201" do
        subject
        expect(response).to have_http_status(201)
      end

      it "returns the new classroom" do
        subject
        expect(json_response[:classroom][:id]).not_to be_blank
        expect(json_response[:classroom][:title]).to eq(title)
        expect(json_response[:classroom][:description]).to eq(description)
      end

      it "creates the classroom" do
        expect{ subject }.to change(Classroom, :count).by(1)
      end

      it "sets the creator to current_user" do
        subject
        expect(json_response[:classroom][:creator_id]).to eq(controller.current_user.id)
      end

      context "classrooms is missing from params" do
        subject { post :create, params: { lesson_id: lesson_id } }
        it "returns a 403" do
          subject
          expect(response).to have_http_status(403)
        end

        it "returns a readable error" do
          subject
          expect(json_response[:errors][0]).to eq("param is missing or the value is empty: classroom")
        end
      end

      context "if title is missing" do
        subject { post :create, params: { classroom: { title: nil, description: description }, lesson_id: lesson_id } }
        it "returns a 403" do
          subject
          expect(response).to have_http_status(403)
        end

        it "returns a readable error" do
          subject
          expect(json_response[:errors][0]).to eq("Title can't be blank")
        end
      end

      context "if title is too long" do
        let(:title) { Faker::Lorem.sentence(10).first(51) }
        it "returns a 403" do
          subject
          expect(response).to have_http_status(403)
        end

        it "returns a readable error" do
          subject
          expect(json_response[:errors][0]).to eq("Title is too long (maximum is 50 characters)")
        end
      end

      context "if description is too long" do
        let(:description) { Faker::Lorem.sentence(100).first(301) }
        it "returns a 403" do
          subject
          expect(response).to have_http_status(403)
        end

        it "returns a readable error" do
          subject
          expect(json_response[:errors][0]).to eq("Description is too long (maximum is 300 characters)")
        end
      end
    end
  end
  describe "#update" do
    subject { patch :update, params: { id: id, classroom: params, lesson_id: lesson_id } }
    let(:params) { { title: title, description: description } }
    let!(:classroom) { create(:classroom, creator: user) }
    let(:id) { classroom.id }
    let(:title) { Faker::ChuckNorris.fact[0..49] }
    let(:description) { Faker::TwinPeaks.quote }
    let(:user) { test_user }

    context "the user is logged" do
      it "fails with a 401" do
        subject
        expect(response).to have_http_status(401)
      end
    end

    context "the user is logged" do
      before do
        auth_me_please
      end

      context "the user isn't the creator" do
        let(:user) { create(:user) }

        it "returns unauthorized" do
          subject
          expect(response).to have_http_status(401)
        end
      end

      it "returns a 200" do
        subject
        expect(response).to have_http_status(200)
      end

      it "returns the updated classroom" do
        subject
        expect(json_response[:classroom][:id]).to eq(id)
        expect(json_response[:classroom][:title]).to eq(title)
        expect(json_response[:classroom][:description]).to eq(description)
      end

      it "updates the classroom" do
        expect{ subject }.to change{ classroom.reload.title }.to(title).and(
          change{ classroom.reload.description }.to(description)
        )
      end

      context "if the id doesn't exist" do
        let(:id) { Faker::Lorem.word }
        it "returns a 404" do
          subject
          expect(response).to have_http_status(404)
        end
      end
    end
  end

  describe "#delete" do
    subject { delete :destroy, params: { id: id, lesson_id: lesson_id } }

    let!(:classroom) { create(:classroom, creator: user) }
    let(:id) { classroom.id }
    let(:user) { test_user }

    context "user is not logged in" do
      it 'cannot delete a classroom' do
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
        context "the user is not the creator" do
          let(:user) { create(:user) }
          it "can't delete the classroom" do
            subject
            expect(response).to have_http_status(401)
          end
        end

        context "the user is the creator" do
          it "return no content" do
            subject
            expect(response).to have_http_status(204)
          end
          it "delete the classroom" do
            subject
            expect(response).to have_http_status(204)
          end
        end
      end
    end
  end
end
