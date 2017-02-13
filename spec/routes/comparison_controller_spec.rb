require 'rails_helper'

describe "Routes", :type => "routing" do
  describe "Comparison" do
    let(:primary_id) { "1" }
    let(:secondary_id) { "2" }

    it "routes to #list for the default route" do
      expect(get("/")).to route_to(:controller => "comparison", :action => "list")
    end

    it "routes to #compare for form submissions" do
      expect(post("/compare")).to route_to(:controller => "comparison", :action => "compare")
    end

    it "routes to #compare for form submissions" do
      expect(post("/compare_ships")).to route_to(:controller => "comparison", :action => "compare_ships")
    end
  end
end
