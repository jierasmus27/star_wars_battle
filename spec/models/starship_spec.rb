require 'rails_helper'

RSpec.describe Starship, type: :model do
  let(:params) {
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
    )
  }

  describe "#find_by_id" do
    before(:each) do
      Rails.cache.clear
    end

    it "sets all attributes received" do
      allow(SwapiRb::Starship).to receive(:find_by_id).with(5).and_return(params)

      starship = Starship.find_by_id(5)

      expect(starship.name).to eq(params.name)
    end

    it "sets the id attribute from the url" do
      allow(SwapiRb::Starship).to receive(:find_by_id).with(5).and_return(params)

      starship = Starship.find_by_id(5)

      expect(starship.id).to eq(5)
    end
  end

  describe "#score" do
    before(:each) do
      @starship = Starship.new
      @starship.length = "0"
      @starship.crew = "0"
      @starship.max_atmosphering_speed = "0"
      @starship.hyperdrive_rating = "0"
      @starship.passengers = "0"
      @starship.cargo_capacity = "0"
    end

    it "assigns its length in points" do
      allow(SwapiRb::Starship).to receive(:find_by_id).with(5).and_return(params)
      starship = Starship.find_by_id(5)

      @starship.length = "100"
      expect(@starship.score).to eq(100)
    end

    it "assigns its crew in points" do
      allow(SwapiRb::Starship).to receive(:find_by_id).with(5).and_return(params)
      starship = Starship.find_by_id(5)

      @starship.crew = "200"
      expect(@starship.score).to eq(200)
    end

    it "assigns its max atmospheric speed in points" do
      allow(SwapiRb::Starship).to receive(:find_by_id).with(5).and_return(params)
      starship = Starship.find_by_id(5)

      @starship.max_atmosphering_speed = "2"
      expect(@starship.score).to eq(2)
    end

    it "assigns hyperdrive_rating in points" do
      allow(SwapiRb::Starship).to receive(:find_by_id).with(5).and_return(params)
      starship = Starship.find_by_id(5)

      @starship.hyperdrive_rating = "20"
      expect(@starship.score).to eq(20)
    end

    it "assigns points for passengers" do
      allow(SwapiRb::Starship).to receive(:find_by_id).with(5).and_return(params)
      starship = Starship.find_by_id(5)

      @starship.passengers = "10"
      expect(@starship.score).to eq(10)
    end

    it "assigns points for cargo_capacity" do
      allow(SwapiRb::Starship).to receive(:find_by_id).with(5).and_return(params)
      starship = Starship.find_by_id(5)

      @starship.cargo_capacity = "10"
      expect(@starship.score).to eq(10)
    end

    it "assigns accumulates points for all values" do
      allow(SwapiRb::Starship).to receive(:find_by_id).with(5).and_return(params)
      starship = Starship.find_by_id(5)

      @starship.length = "10"
      @starship.crew = "10"
      @starship.max_atmosphering_speed = "10"
      @starship.hyperdrive_rating = "10"
      @starship.passengers = "10"
      @starship.cargo_capacity = "10"
      expect(@starship.score).to eq(60)
    end
  end

  describe "#compare_to" do
    before(:each) do
      @primary = Starship.new
      @primary.name = "Imperial shuttle"
      @primary.length = "0"
      @primary.crew = "0"
      @primary.max_atmosphering_speed = "0"
      @primary.hyperdrive_rating = "0"
      @primary.passengers = "0"
      @primary.cargo_capacity = "0"

      @secondary = Starship.new
      @secondary.name = "Death Star"
      @secondary.length = "0"
      @secondary.crew = "0"
      @secondary.max_atmosphering_speed = "0"
      @secondary.hyperdrive_rating = "0"
      @secondary.passengers = "0"
      @secondary.cargo_capacity = "0"
    end

    it "correctly picks a primary winner based on score" do
      @primary.passengers = "1000"

      expect(@primary.compared_to(@secondary)["winner"]).to eq("Imperial shuttle")
    end

    it "correctly picks a secondary winner based on score" do
      @secondary.passengers = "1000"

      expect(@primary.compared_to(@secondary)["winner"]).to eq("Death Star")
    end

    it "correctly picks a tie based on score" do
      @primary.passengers = "1000"
      @secondary.passengers = "1000"

      expect(@primary.compared_to(@secondary)["winner"]).to eq("It is a tie")
    end

    it "correctly titles the winner for passangers as a strength" do
      @primary.passengers = "1000"

      expect(@primary.compared_to(@secondary)["strengths"][0]).to eq("Imperial shuttle can carry more passengers")
    end

    it "correctly titles the loser for passengers as a strength" do
      @secondary.passengers = "1000"

      expect(@primary.compared_to(@secondary)["weaknesses"][0]).to eq("Imperial shuttle can carry fewer passengers")
    end
  end

  # describe "Comparison" do
  #   before(:each) do
  #     @primary = Person.new
  #     @primary.name = "Luke Skywalker"
  #     @primary.films = []
  #     @primary.vehicles = []
  #     @primary.starships = []
  #     @primary.height = 0
  #     @primary.mass = 0
  #
  #     @secondary = Person.new
  #     @secondary.name = "Darth Vader"
  #     @secondary.films = []
  #     @secondary.vehicles = []
  #     @secondary.starships = []
  #     @secondary.height = 0
  #     @secondary.mass = 0
  #   end
  #
  #   it "successfully implements the spaceship for the primary having a better score" do
  #     @primary.mass = "1000"
  #
  #     expect(@primary > @secondary).to be(true)
  #   end
  #
  #   it "successfully implements the spaceship for the secondary having a better score" do
  #     @secondary.mass = "1000"
  #
  #     expect(@primary < @secondary).to be(true)
  #   end
  #
  #   it "successfully implements the spaceship for the primary and secondary being equal" do
  #     @primary.mass = "1000"
  #     @secondary.mass = "1000"
  #
  #     expect(@primary == @secondary).to be(true)
  #   end
  # end

end
