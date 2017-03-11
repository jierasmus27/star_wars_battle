require 'rails_helper'

describe "Routes", :type => "routing" do
  describe "NewSeriesPeople" do

    it "routes to #new for the new action" do
      expect(get("/new_series_people/new")).to route_to(:controller => "new_series_people", :action => "new")
    end

    it "routes to #create for the create action" do
      expect(post("/new_series_people")).to route_to(:controller => "new_series_people", :action => "create")
    end

    it "routes to #show for the show action" do
      expect(get("/new_series_people/1")).to route_to(:controller => "new_series_people", :action => "show", :id => "1")
    end

    it "routes to #index for the index action" do
      expect(get("/new_series_people")).to route_to(:controller => "new_series_people", :action => "index")
    end

    it "routes to #delete for the delete action" do
      expect(delete("/new_series_people/1")).to route_to(:controller => "new_series_people", :action => "destroy", :id => "1")
    end

  end
end
