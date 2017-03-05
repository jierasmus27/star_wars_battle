require 'rails_helper'

describe "Routes", :type => "routing" do
  describe "NewSeriesFilm" do

    it "routes to #new for the new action" do
      expect(get("/new_series_films/new")).to route_to(:controller => "new_series_films", :action => "new")
    end

  end
end
