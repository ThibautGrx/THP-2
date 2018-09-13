require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  describe "#index" do
    let(:page_params) { { number: 1, size: 5 } }

    subject { get :index, params: page_params }

    context "when not logged in" do
      it 'cannot get all the lessons' do
        subject
        expect(json_response[:errors][0]).to eq("You need to sign in or sign up before continuing.")
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in" do
      before do
        auth_me_please
      end

      let!(:lessons) { create_list(:lesson, 10) }

      it 'can get all the lessons' do
        subject
        expect(json_response[:lessons].length).to eq(5)
      end

      it "returns a 200" do
        subject
        expect(response).to have_http_status(200)
      end

      it "returns meta with informations about pagination" do
        subject
        expect(json_response[:meta][:current_page]).to eq(1)
        expect(json_response[:meta][:next_page]).to eq(2)
        expect(json_response[:meta][:prev_page]).to be_nil
        expect(json_response[:meta][:total_pages]).to eq(2)
        expect(json_response[:meta][:total_count]).to eq(10)
      end
    end
  end

  describe "#show" do
    subject { get :show, params: { id: id } }

    let(:lesson) { create(:lesson, :with_classrooms) }
    let(:id) { lesson.id }

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
        it 'returns the lesson' do
          subject
          expect(json_response[:lesson][:id]).to eq(lesson.id)
          expect(json_response[:lesson][:title]).to eq(lesson.title)
          expect(json_response[:lesson][:description]).to eq(lesson.description)
          expect(json_response[:lesson][:creator_id]).to eq(lesson.creator_id)
          expect(json_response[:lesson][:classrooms]).to eq(lesson.classrooms.pluck(:id))
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
          expect(json_response[:errors][0][:detail]).to eq("Couldn't find Lesson with 'id'=#{id}")
        end
      end
    end
  end

  describe "#create" do
    subject { post :create, params: { lesson: { title: title, description: description } } }

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

      it "returns a 201" do
        subject
        expect(response).to have_http_status(201)
      end

      it "returns the new lesson" do
        subject
        expect(json_response[:lesson][:id]).not_to be_blank
        expect(json_response[:lesson][:title]).to eq(title)
        expect(json_response[:lesson][:description]).to eq(description)
      end

      it "creates the lesson" do
        expect{ subject }.to change(Lesson, :count).by(1)
      end

      it "sets the creator to current_user" do
        subject
        expect(json_response[:lesson][:creator_id]).to eq(controller.current_user.id)
      end

      context "lesson is missing from params" do
        subject { post :create, params: {} }
        it "returns a 403" do
          subject
          expect(response).to have_http_status(403)
        end

        it "returns a readable error" do
          subject
          expect(json_response[:errors][0]).to eq("param is missing or the value is empty: lesson")
        end
      end

      context "if title is missing" do
        subject { post :create, params: { lesson: { title: nil, description: description } } }
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
    subject { patch :update, params: { id: id, lesson: params } }
    let(:params) { { title: title, description: description } }
    let!(:lesson) { create(:lesson, creator: user) }
    let(:id) { lesson.id }
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

      it "returns the updated lesson" do
        subject
        expect(json_response[:lesson][:id]).to eq(id)
        expect(json_response[:lesson][:title]).to eq(title)
        expect(json_response[:lesson][:description]).to eq(description)
      end

      it "updates the lesson" do
        expect{ subject }.to change{ lesson.reload.title }.to(title).and(
          change{ lesson.reload.description }.to(description)
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
    subject { delete :destroy, params: { id: id } }

    let!(:lesson) { create(:lesson, creator: user) }
    let(:id) { lesson.id }
    let(:user) { test_user }

    context "user is not logged in" do
      it 'cannot delete a lesson' do
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
          it "can't delete the lesson" do
            subject
            expect(response).to have_http_status(401)
          end
        end

        context "the user is the creator" do
          it "return no content" do
            subject
            expect(response).to have_http_status(204)
          end
          it "delete the lesson" do
            subject
            expect(response).to have_http_status(204)
          end
          context "the lesson has classroom" do
            let!(:lesson) { create(:lesson, :with_classrooms, creator: user) }
            it "delete all classrooms" do
              expect{ subject }.to change(Classroom, :count).to(0)
            end
          end
        end
      end
    end
  end
end
