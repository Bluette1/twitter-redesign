require "rails_helper"

RSpec.describe TrendsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/trends").to route_to("trends#index")
    end
  end
end
