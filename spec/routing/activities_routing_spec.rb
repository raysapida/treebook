require "rails_helper"

RSpec.describe ActivitiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/activities").to route_to("activities#index")
    end

  end
end
