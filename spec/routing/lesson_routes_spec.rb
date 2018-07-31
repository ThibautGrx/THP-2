require 'rails_helper'

describe "routing to lessons" do
  it "routes /lessons to lessons#index" do
    expect(get: "/lessons").to route_to(
      controller: "lessons",
      action: "index"
    )
  end

  it "routes /lessons/:id to lessons#show" do
    expect(get: "/lessons/79cfcc41-edcb-4f5f-91c9-3fb9b3733509").to route_to(
      controller: "lessons",
      action: "show",
      id: "79cfcc41-edcb-4f5f-91c9-3fb9b3733509"
    )
  end

  it "routes /lessons to lessons#create" do
    expect(post: "/lessons").to route_to(
      controller: "lessons",
      action: "create"
    )
  end

  it "routes /lessons/:id to lessons#update" do
    expect(put: "/lessons/79cfcc41-edcb-4f5f-91c9-3fb9b3733509").to route_to(
      controller: "lessons",
      action: "update",
      id: "79cfcc41-edcb-4f5f-91c9-3fb9b3733509"
    )
  end

  it "routes /lessons/:id to lessons#destroy" do
    expect(delete: "/lessons/79cfcc41-edcb-4f5f-91c9-3fb9b3733509").to route_to(
      controller: "lessons",
      action: "destroy",
      id: "79cfcc41-edcb-4f5f-91c9-3fb9b3733509"
    )
  end
end
