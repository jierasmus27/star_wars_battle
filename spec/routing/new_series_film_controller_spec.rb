require 'rails_helper'

describe "Routes", :type => "routing" do
  describe "NewSeriesFilm" do

    it "routes to #new for the new action" do
      expect(get("/new_series_films/new")).to route_to(:controller => "new_series_films", :action => "new")
    end

    it "routes to #create for the create action" do
      expect(post("/new_series_films")).to route_to(:controller => "new_series_films", :action => "create")
    end

    it "routes to #index for the index action" do
      expect(get("/new_series_films")).to route_to(:controller => "new_series_films", :action => "index")
    end

    it "routes to #show for the show action" do
      expect(get("/new_series_films/1")).to route_to(:controller => "new_series_films", :action => "show", :id => "1")
    end

  end
end
