require 'rails_helper'

RSpec.describe ComparisonController, type: :controller do
  let (:all_params) { [
      OpenStruct.new(
        :birth_year => "19 BBY",
        :eye_color => "Blue",
        :films => [
            "http://swapi.co/api/films/1/"
        ],
        :gender => "Male",
        :hair_color => "Blond",
        :height => "172",
        :homeworld => "http://swapi.co/api/planets/1/",
        :mass => "77",
        :name => "Luke Skywalker",
        :skin_color => "Fair",
        :created => "2014-12-09T13:50:51.644000Z",
        :edited => "2014-12-10T13:52:43.172000Z",
        :species => [
               "http://swapi.co/api/species/1/"
        ],
        :starships => [
               "http://swapi.co/api/starships/12/"
        ],
        :url => "http://swapi.co/api/people/1/",
        :vehicles => [
               "http://swapi.co/api/vehicles/14/"
        ]
      ),
      OpenStruct.new(
        :name => "C-3PO",
        :height => "167",
        :mass => "75",
        :hair_color => "n/a",
        :skin_color => "gold",
        :eye_color => "yellow",
        :birth_year => "112BBY",
        :gender => "n/a",
        :homeworld => "http://swapi.co/api/planets/1/",
        :films => [
            "http://swapi.co/api/films/5/",
            "http://swapi.co/api/films/4/",
            "http://swapi.co/api/films/6/",
            "http://swapi.co/api/films/3/",
            "http://swapi.co/api/films/2/",
            "http://swapi.co/api/films/1/"
        ],
        :species => [
            "http://swapi.co/api/species/2/"
        ],
        :vehicles => [],
        :starships => [],
        :created => "2014-12-10T15:10:51.357000Z",
        :edited => "2014-12-20T21:17:50.309000Z",
        :url => "http://swapi.co/api/people/2/"
      )]
  }

  let(:starship_params) { [
      OpenStruct.new(
        :name => "Sentinel-class landing craft",
        :model => "Sentinel-class landing craft",
        :manufacturer => "Sienar Fleet Systems, Cyngus Spaceworks",
        :cost_in_credits => "240000",
        :length => "38",
        :max_atmosphering_speed => "1000",
        :crew => "5",
        :passengers => "75",
        :cargo_capacity => "180000",
        :consumables => "1 month",
        :hyperdrive_rating => "1.0",
        :MGLT => "70",
        :starship_class => "landing craft",
        :pilots => [],
        :films => [
          "http://swapi.co/api/films/1/"
        ],
        :created => "2014-12-10T15:48:00.586000Z",
        :edited => "2014-12-22T17:35:44.431407Z",
        :url => "http://swapi.co/api/starships/5/"
      ),
      OpenStruct.new(
        :name => "Death Star",
        :model => "DS-1 Orbital Battle Station",
        :manufacturer => "Imperial Department of Military Research, Sienar Fleet Systems",
        :cost_in_credits => "1000000000000",
        :length => "120000",
        :max_atmosphering_speed => "1",
        :crew => "342953",
        :passengers => "843342",
        :cargo_capacity => "1000000000000",
        :consumables => "3 years",
        :hyperdrive_rating => "4.0",
        :MGLT => "10",
        :starship_class => "Deep Space Mobile Battlestation",
        :pilots => [],
        :films => [
            "http://swapi.co/api/films/1/"
        ],
        :created => "2014-12-10T16:36:50.509000Z",
        :edited => "2014-12-22T17:35:44.452589Z",
        :url => "http://swapi.co/api/starships/9/"
      ),
    ]
  }

  describe "GET 'list'" do
    before(:each) do
      Rails.cache.clear
    end

    it "assigns an array to people" do
      person1 = Person.new(all_params[0])
      person2 = Person.new(all_params[1])

      allow(SwapiRb::People).to receive(:all).and_return(all_params)
      allow(SwapiRb::Starship).to receive(:all).and_return(starship_params)

      get :list
      expect(assigns(:people)).to be_instance_of(Array)
      expect(assigns(:people).size).to eq(2)
    end

    it "assigns an array to starships" do
      starship1 = Starship.new(starship_params[0])
      starship2 = Starship.new(starship_params[1])

      allow(SwapiRb::People).to receive(:all).and_return(all_params)
      allow(SwapiRb::Starship).to receive(:all).and_return(starship_params)

      get :list
      expect(assigns(:starships)).to be_instance_of(Array)
      expect(assigns(:starships).size).to eq(2)
    end
  end

  describe "POST 'compare'" do
    before(:each) do
      Rails.cache.clear
    end

    it "sets the primary object correctly" do
      allow(SwapiRb::People).to receive(:find_by_id).and_return(all_params[0])

      post :compare, params = {:primary_id => 1, :secondary_id => 2}
      expect(assigns(:primary)).to be_instance_of(Person)
      expect(assigns(:primary).name).to eq("Luke Skywalker")
    end

    it "sets the secondary object correctly" do
      allow(SwapiRb::People).to receive(:find_by_id).and_return(all_params[1])

      post :compare, params = {:primary_id => 1, :secondary_id => 2}
      expect(assigns(:secondary)).to be_instance_of(Person)
      expect(assigns(:secondary).name).to eq("C-3PO")
    end

    it "sets the comparison to a hash" do
      allow(SwapiRb::People).to receive(:find_by_id).with('1').and_return(all_params[0])
      allow(SwapiRb::People).to receive(:find_by_id).with('2').and_return(all_params[1])

      post :compare, params = {:primary_id => 1, :secondary_id => 2}
      expect(assigns(:results)).to be_instance_of(Hash)
    end

    it "the comparison hash has the 4 correct keys" do
      allow(SwapiRb::People).to receive(:find_by_id).with('1').and_return(all_params[0])
      allow(SwapiRb::People).to receive(:find_by_id).with('2').and_return(all_params[1])

      post :compare, params = {:primary_id => 1, :secondary_id => 2}
      expect(assigns(:results)).to be_instance_of(Hash)
      expect(assigns(:results)).to have_key("winner")
      expect(assigns(:results)).to have_key("strengths")
      expect(assigns(:results)).to have_key("weaknesses")
      expect(assigns(:results)).to have_key("ties")
    end
  end

  describe "POST 'compare_ships'" do
    before(:each) do
      Rails.cache.clear
    end

    it "sets the primary object correctly" do
      allow(SwapiRb::Starship).to receive(:find_by_id).and_return(starship_params[0])

      post :compare_ships, params = {:primary_ship_id => 5, :secondary_ship_id => 9}
      expect(assigns(:primary)).to be_instance_of(Starship)
      expect(assigns(:primary).name).to eq("Sentinel-class landing craft")
    end

    it "sets the secondary object correctly" do
      allow(SwapiRb::Starship).to receive(:find_by_id).and_return(starship_params[1])

      post :compare_ships, params = {:primary_ship_id => 5, :secondary_ship_id => 9}
      expect(assigns(:secondary)).to be_instance_of(Starship)
      expect(assigns(:secondary).name).to eq("Death Star")
    end

    it "sets the comparison to a hash" do
      allow(SwapiRb::Starship).to receive(:find_by_id).with('5').and_return(starship_params[0])
      allow(SwapiRb::Starship).to receive(:find_by_id).with('9').and_return(starship_params[1])

      post :compare_ships, params = {:primary_ship_id => 5, :secondary_ship_id => 9}
      expect(assigns(:results)).to be_instance_of(Hash)
    end

    it "the comparison hash has the 4 correct keys" do
      allow(SwapiRb::Starship).to receive(:find_by_id).with('5').and_return(starship_params[0])
      allow(SwapiRb::Starship).to receive(:find_by_id).with('9').and_return(starship_params[1])

      post :compare_ships, params = {:primary_ship_id => 5, :secondary_ship_id => 9}
      expect(assigns(:results)).to be_instance_of(Hash)
      expect(assigns(:results)).to have_key("winner")
      expect(assigns(:results)).to have_key("strengths")
      expect(assigns(:results)).to have_key("weaknesses")
      expect(assigns(:results)).to have_key("ties")
    end
  end
end
