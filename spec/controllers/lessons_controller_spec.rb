require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  describe "POST create" do
    let(:title) { Faker::Beer.name }
    let(:description) { Faker::ChuckNorris.fact }

    subject { post :create, params: { title: title, description: description } }

    context 'lesson is valid' do
      it "create the lesson " do
        expect{ subject }.to change(Lesson, :count).by(1)
        expect(json_response[:lesson][:title]).to eq(title)
        expect(json_response[:lesson][:description]).to eq(description)
        first_lesson = Lesson.first
        expect(first_lesson.title).to eq(title)
        expect(first_lesson.description).to eq(description)
        expect(response.status).to eq(201)
      end
    end

    context 'title and descritpion are not  valid' do
      let(:title) { nil }
      let(:description) { nil }
      it "fails because title&description = nil" do
        expect{ subject }.not_to(change(Lesson, :count))
        expect(response.status).to eq(403)
        expect(json_response[:errors][:title][0]).to eq("can't be blank")
        expect(json_response[:errors][:description][0]).to eq("can't be blank")
      end
    end

    context 'title and descritpion are not  valid' do
      let(:title) { 'a' * 51 }
      let(:description) { 'a' * 301 }
      it "fails because title&description are too long" do
        expect{ subject }.not_to(change(Lesson, :count))
        expect(response.status).to eq(403)
        expect(json_response[:errors][:title][0]).to eq("is too long (maximum is 50 characters)")
        expect(json_response[:errors][:description][0]).to eq("is too long (maximum is 300 characters)")
      end
    end
  end

  describe "GET show" do
    let(:lesson) { create(:lesson) }
    let(:id) { lesson.id }

    subject { get :show, params: { id: id } }

    it "renders the lesson" do
      subject
      expect(json_response[:lesson][:id]).to eq(lesson.id)
      expect(json_response[:lesson][:title]).to eq(lesson.title)
      expect(json_response[:lesson][:description]).to eq(lesson.description)
      expect(response.status).to eq(200)
    end

    context "the lesson doesn't exist" do
      let(:id) { "79cfcc41-edcb-4f5f-91c9-3fb9b3733509" }
      it "return not found" do
        subject
        expect(response.status).to eq(404)
      end
    end
  end

  describe "PATCH update" do
    let!(:lesson) { create(:lesson) }
    let(:id) { lesson.id }
    let(:title) { Faker::Beer.name }
    let(:description) { Faker::ChuckNorris.fact }

    subject do
      patch :update, params: { id: id, title: title, description: description }
    end

    context 'lesson is valid' do
      it "update the lesson " do
        expect{ subject }.to change{ lesson.reload.title }.to(title)
        expect(json_response[:lesson][:title]).to eq(title)
        first_lesson = Lesson.first
        expect(first_lesson.title).to eq(title)
        expect(response.status).to eq(201)
      end
      it "update the lesson " do
        expect{ subject }.to change{ lesson.reload.description }.to(description)
        expect(json_response[:lesson][:description]).to eq(description)
        first_lesson = Lesson.first
        expect(first_lesson.description).to eq(description)
        expect(response.status).to eq(201)
      end
    end
  end

  describe "GET #index" do
    let!(:lessons) { create_list(:lesson, 10) }

    subject do
      get :index
    end

    it "returns all the turtles" do
      subject
      expect(json_response[:lessons].size).to eq(10)
    end
  end

  describe "DELETE #destroy" do
    let!(:lesson) { create(:lesson) }
    let(:id) { lesson.id }

    subject do
      delete :destroy, params: { id: id }
    end

    it "delete the turtle" do
      expect{ subject }.to change(Lesson, :count).from(1).to(0)
    end

    it "return 204" do
      subject
      expect(response.status).to eq(204)
    end

    context 'lesson doesn\'t exist' do
      let(:id) { "79cfcc41-edcb-4f5f-91c9-3fb9b3733509" }
      it 'return not found' do
        subject
        expect(response.status).to eq(404)
      end
    end
  end
end
