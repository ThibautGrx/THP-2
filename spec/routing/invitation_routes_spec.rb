require 'rails_helper'

describe "routing to invitations" do
  let(:lesson) { create(:lesson, :with_classrooms) }
  let(:classroom_id) { lesson.classrooms.first.id }
  let(:lesson_id) { lesson.id }
  it "routes /lessons/:id/classroom/:id/invitations to invitations#index" do
    expect(get: "/lessons/#{lesson_id}/classrooms/#{classroom_id}/invitations").to route_to(
      controller: "invitations",
      action: "index",
      lesson_id: lesson_id,
      classroom_id: classroom_id
    )
  end

  it "routes /lessons/:id/classroom/:id/invitations/:id to invitations#show" do
    expect(get: "/lessons/#{lesson_id}/classrooms/#{classroom_id}/invitations/79cfcc41-edcb-4f5f-91c9-3fb9b3733509").to route_to(
      controller: "invitations",
      action: "show",
      lesson_id: lesson_id,
      id: "79cfcc41-edcb-4f5f-91c9-3fb9b3733509",
      classroom_id: classroom_id
    )
  end

  it "routes /lessons/:id/classroom/:id/invitations to invitations#create" do
    expect(post: "/lessons/#{lesson_id}/classrooms/#{classroom_id}/invitations").to route_to(
      controller: "invitations",
      lesson_id: lesson_id,
      action: "create",
      classroom_id: classroom_id
    )
  end

  it "routes /lessons/:id/classroom/:id/invitations/:id to invitations#update" do
    expect(put: "/lessons/#{lesson_id}/classrooms/#{classroom_id}/invitations/79cfcc41-edcb-4f5f-91c9-3fb9b3733509").to route_to(
      controller: "invitations",
      action: "update",
      lesson_id: lesson_id,
      id: "79cfcc41-edcb-4f5f-91c9-3fb9b3733509",
      classroom_id: classroom_id
    )
  end

  it "routes /lessons/:id/classroom/:id/invitations/:id to invitations#destroy" do
    expect(delete: "/lessons/#{lesson_id}/classrooms/#{classroom_id}/invitations/79cfcc41-edcb-4f5f-91c9-3fb9b3733509").to route_to(
      controller: "invitations",
      action: "destroy",
      lesson_id: lesson_id,
      id: "79cfcc41-edcb-4f5f-91c9-3fb9b3733509",
      classroom_id: classroom_id
    )
  end
end
