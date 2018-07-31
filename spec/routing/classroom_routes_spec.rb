require 'rails_helper'

describe "routing to classrooms" do
  let(:lesson) { create(:lesson) }
  let(:id) { lesson.id }
  it "routes /lessons/:id/classrooms to classrooms#index" do
    expect(get: "/lessons/#{id}/classrooms").to route_to(
      controller: "classrooms",
      action: "index",
      lesson_id: id
    )
  end

  it "routes /lessons/:id/classrooms/:id to classrooms#show" do
    expect(get: "/lessons/#{id}/classrooms/79cfcc41-edcb-4f5f-91c9-3fb9b3733509").to route_to(
      controller: "classrooms",
      action: "show",
      lesson_id: id,
      id: "79cfcc41-edcb-4f5f-91c9-3fb9b3733509"
    )
  end

  it "routes /lessons/:id/classrooms to classrooms#create" do
    expect(post: "/lessons/#{id}/classrooms").to route_to(
      controller: "classrooms",
      lesson_id: id,
      action: "create"
    )
  end

  it "routes /lessons/:id/classrooms/:id to classrooms#update" do
    expect(put: "/lessons/#{id}/classrooms/79cfcc41-edcb-4f5f-91c9-3fb9b3733509").to route_to(
      controller: "classrooms",
      action: "update",
      lesson_id: id,
      id: "79cfcc41-edcb-4f5f-91c9-3fb9b3733509"
    )
  end

  it "routes /lessons/:id/classrooms/:id to classrooms#destroy" do
    expect(delete: "/lessons/#{id}/classrooms/79cfcc41-edcb-4f5f-91c9-3fb9b3733509").to route_to(
      controller: "classrooms",
      action: "destroy",
      lesson_id: id,
      id: "79cfcc41-edcb-4f5f-91c9-3fb9b3733509"
    )
  end
end
