require 'rails_helper'

RSpec.describe ComparisonController, type: :controller do
  let (:luke_skywalker) { create(:person_request, :luke_skywalker) }
  let (:c3po) { create(:person_request, :c3po) }
  let (:person_all_result ) { [luke_skywalker, c3po] }

  let (:sentinel) { create(:starship_request, :sentinel) }
  let (:death_star) { create(:starship_request, :death_star) }
  let (:starship_all_result ) { [sentinel, death_star] }

  describe "GET 'list'" do
    before(:each) do
      Rails.cache.clear

      allow(SwapiRb::People).to receive(:all).and_return(person_all_result)
      allow(SwapiRb::Starship).to receive(:all).and_return(starship_all_result)
    end

    it "assigns an array to people" do
      get :list

      expect(assigns(:people)).to be_instance_of(Array)
      expect(assigns(:people).size).to eq(2)
    end

    it "assigns an array to starships" do
      get :list

      expect(assigns(:starships)).to be_instance_of(Array)
      expect(assigns(:starships).size).to eq(2)
    end
  end

  describe "POST 'compare'" do
    before(:each) do
      Rails.cache.clear

      allow(SwapiRb::People).to receive(:find_by_id).with('1').and_return(luke_skywalker)
      allow(SwapiRb::People).to receive(:find_by_id).with('2').and_return(c3po)
    end

    it "sets the primary object correctly" do
      post :compare, params = {:primary_id => 1, :secondary_id => 2}
      expect(assigns(:primary)).to be_instance_of(Person)
      expect(assigns(:primary).name).to eq(luke_skywalker.name)
    end

    it "sets the secondary object correctly" do
      post :compare, params = {:primary_id => 1, :secondary_id => 2}
      expect(assigns(:secondary)).to be_instance_of(Person)
      expect(assigns(:secondary).name).to eq(c3po.name)
    end

    it "sets the comparison to a hash" do
      post :compare, params = {:primary_id => 1, :secondary_id => 2}
      expect(assigns(:results)).to be_instance_of(Hash)
    end

    it "the comparison hash has the 4 correct keys" do
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

      allow(SwapiRb::Starship).to receive(:find_by_id).with('5').and_return(sentinel)
      allow(SwapiRb::Starship).to receive(:find_by_id).with('9').and_return(death_star)
    end

    it "sets the primary object correctly" do
      post :compare_ships, params = {:primary_ship_id => 5, :secondary_ship_id => 9}

      expect(assigns(:primary)).to be_instance_of(Starship)
      expect(assigns(:primary).name).to eq(sentinel.name)
    end

    it "sets the secondary object correctly" do
      post :compare_ships, params = {:primary_ship_id => 5, :secondary_ship_id => 9}

      expect(assigns(:secondary)).to be_instance_of(Starship)
      expect(assigns(:secondary).name).to eq(death_star.name)
    end

    it "sets the comparison to a hash" do
      post :compare_ships, params = {:primary_ship_id => 5, :secondary_ship_id => 9}

      expect(assigns(:results)).to be_instance_of(Hash)
    end

    it "the comparison hash has the 4 correct keys" do
      post :compare_ships, params = {:primary_ship_id => 5, :secondary_ship_id => 9}

      expect(assigns(:results)).to be_instance_of(Hash)
      expect(assigns(:results)).to have_key("winner")
      expect(assigns(:results)).to have_key("strengths")
      expect(assigns(:results)).to have_key("weaknesses")
      expect(assigns(:results)).to have_key("ties")
    end
  end
end
