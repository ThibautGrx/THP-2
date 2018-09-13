require 'rails_helper'

RSpec.describe StepsController, type: :controller do
  let!(:lesson) { create(:lesson, creator: user) }
  let(:user) { test_user }
  let(:lesson_id) { lesson.id }
  describe "#index" do
    subject { get :index, params: { lesson_id: lesson_id } }

    context "when not logged in" do
      it 'cannot get all the steps' do
        subject
        expect(json_response[:errors][0]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in" do
      before do
        auth_me_please
      end

      let!(:steps) { create_list(:step, 10) }

      it 'can get all the steps' do
        subject
        expect(json_response[:steps].length).to eq(10)
      end

      it "returns a 200" do
        subject
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#show" do
    subject { get :show, params: { id: id, lesson_id: lesson_id } }

    let(:step) { create(:step, lesson: lesson) }
    let(:id) { step.id }

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
        it 'returns the step' do
          subject
          expect(json_response[:step][:id]).to eq(step.id)
          expect(json_response[:step][:title]).to eq(step.title)
          expect(json_response[:step][:description]).to eq(step.description)
          expect(json_response[:step][:lesson_id]).to eq(step.lesson_id)
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
          expect(json_response[:errors][0][:detail]).to eq("Couldn't find Step with 'id'=#{id}")
        end
      end
    end
  end

  describe "#create" do
    subject { post :create, params: { lesson_id: lesson_id, step: { title: title, description: description } } }

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

        it 'can\'t create a step' do
          subject
          expect(response).to have_http_status(401)
        end
      end

      it "returns a 201" do
        subject
        expect(response).to have_http_status(201)
      end

      it "returns the new step" do
        subject
        expect(json_response[:step][:id]).not_to be_blank
        expect(json_response[:step][:title]).to eq(title)
        expect(json_response[:step][:description]).to eq(description)
      end

      it "creates the step" do
        expect{ subject }.to change(Step, :count).by(1)
      end

      context "steps is missing from params" do
        subject { post :create, params: { lesson_id: lesson_id } }
        it "returns a 403" do
          subject
          expect(response).to have_http_status(403)
        end

        it "returns a readable error" do
          subject
          expect(json_response[:errors][0]).to eq("param is missing or the value is empty: step")
        end
      end

      context "if title is missing" do
        subject { post :create, params: { step: { title: nil, description: description }, lesson_id: lesson_id } }
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
    let(:step) { create(:step, lesson: lesson) }
    subject { patch :update, params: { id: id, step: params, lesson_id: lesson_id } }
    let(:params) { { title: title, description: description } }
    let(:id) { step.id }
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

      it "returns the updated step" do
        subject
        expect(json_response[:step][:id]).to eq(id)
        expect(json_response[:step][:title]).to eq(title)
        expect(json_response[:step][:description]).to eq(description)
      end

      it "updates the step" do
        expect{ subject }.to change{ step.reload.title }.to(title).and(
          change{ step.reload.description }.to(description)
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

    let!(:step) { create(:step, lesson: lesson) }
    let(:id) { step.id }
    let(:user) { test_user }

    context "user is not logged in" do
      it 'cannot delete a step' do
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
          let!(:user) { create(:user) }
          it "can't delete the step" do
            subject
            expect(response).to have_http_status(401)
          end
        end

        context "the user is the creator" do
          it "return no content" do
            subject
            expect(response).to have_http_status(204)
          end
          it "delete the step" do
            subject
            expect(response).to have_http_status(204)
          end
        end
      end
    end
  end
end
