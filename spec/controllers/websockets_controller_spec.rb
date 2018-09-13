require 'rails_helper'

RSpec.describe WebsocketsController, type: :controller do
  describe "GET #create" do
    subject { post :create }
    context 'the user is not logged in' do
      it "create à token" do
        subject
        expect(response).to have_http_status(401)
      end
    end
    context 'the user is logged in' do
      before { auth_me_please }
      it "create à token" do
        subject
        expect(controller.current_user.token.length).to eq(1)
      end
      it "add job to queue" do
        expect{ subject }.to change { ActiveJob::Base.queue_adapter.enqueued_jobs.count }.by 1
      end
    end
  end
end
