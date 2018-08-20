require 'rails_helper'

describe "routing to invitations" do
  let(:lesson) { create(:lesson, :with_classrooms) }
  let(:classroom_id) { lesson.classrooms.first.id }
  it "routes /lessons/:id/classroom/:id/invitations to invitations#index" do
    expect(get: "/invitations").to route_to(
      controller: "invitations",
      action: "index",
    )
  end

  it "routes /invitations/:id to invitations#show" do
    expect(get: "/invitations/79cfcc41-edcb-4f5f-91c9-3fb9b3733509").to route_to(
      controller: "invitations",
      action: "show",
      id: "79cfcc41-edcb-4f5f-91c9-3fb9b3733509"
    )
  end

  it "routes /classroom/:id/invitations to invitations#create" do
    expect(post: "/classrooms/#{classroom_id}/invitations").to route_to(
      controller: "invitations",
      action: "create",
      classroom_id: classroom_id
    )
  end

  it "routes /invitations/:id to invitations#update" do
    expect(put: "/invitations/79cfcc41-edcb-4f5f-91c9-3fb9b3733509").to route_to(
      controller: "invitations",
      action: "update",
      id: "79cfcc41-edcb-4f5f-91c9-3fb9b3733509",
    )
  end

  it "routes /lessons/:id/classroom/:id/invitations/:id to invitations#destroy" do
    expect(delete: "/invitations/79cfcc41-edcb-4f5f-91c9-3fb9b3733509").to route_to(
      controller: "invitations",
      action: "destroy",
      id: "79cfcc41-edcb-4f5f-91c9-3fb9b3733509"
    )
  end
end
