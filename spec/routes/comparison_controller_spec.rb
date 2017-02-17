require 'rails_helper'

describe "Routes", :type => "routing" do
  describe "Comparison" do

    it "routes to #index for the default route" do
      expect(get("/")).to route_to(:controller => "comparison", :action => "index")
    end

    it "routes to #compare for form submissions" do
      expect(get("/compare/person")).to route_to(:controller => "comparison", :action => "compare", :entity => "person")
    end

  end
end
