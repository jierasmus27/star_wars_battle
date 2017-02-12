require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:params) {
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
      ])
  }

  describe "#find_by_id" do
    it "sets all attributes received" do
      allow(SwapiRb::People).to receive(:find_by_id).with(1).and_return(params)

      person = Person.find_by_id(1)

      expect(person.name).to eq(params.name)
    end

    it "sets the id attribute from the url" do
      allow(SwapiRb::People).to receive(:find_by_id).with(1).and_return(params)

      person = Person.find_by_id(1)

      expect(person.id).to eq(1)
    end
  end

  describe "#score" do
    before(:each) do
      @person = Person.new
      @person.films = []
      @person.vehicles = []
      @person.starships = []
      @person.height = 0
      @person.mass = 0
    end

    it "assigns one point for each film the character was in" do
      allow(SwapiRb::People).to receive(:find_by_id).with(1).and_return(params)
      person = Person.find_by_id(1)

      @person.films = ["A New Hope", "The Force Awakens"]
      expect(@person.score).to eq(2)
    end

    it "assigns two points per vehicle" do
      allow(SwapiRb::People).to receive(:find_by_id).with(1).and_return(params)
      person = Person.find_by_id(1)

      @person.vehicles = ["AT-AT"]
      expect(@person.score).to eq(2)
    end

    it "assigns two points per starship" do
      allow(SwapiRb::People).to receive(:find_by_id).with(1).and_return(params)
      person = Person.find_by_id(1)

      @person.starships = ["Millennium Falcon"]
      expect(@person.score).to eq(2)
    end

    it "assigns points for height" do
      allow(SwapiRb::People).to receive(:find_by_id).with(1).and_return(params)
      person = Person.find_by_id(1)

      @person.height = "170"
      expect(@person.score).to eq(3)
    end

    it "assigns points for mass" do
      allow(SwapiRb::People).to receive(:find_by_id).with(1).and_return(params)
      person = Person.find_by_id(1)

      @person.mass = "120"
      expect(@person.score).to eq(3)
    end

    it "assigns accumulates points for all values" do
      allow(SwapiRb::People).to receive(:find_by_id).with(1).and_return(params)
      person = Person.find_by_id(1)

      @person.films = ["A New Hope", "The Force Awakens"]
      @person.vehicles = ["AT-AT"]
      @person.starships = ["Millennium Falcon"]
      @person.height = "170"
      @person.mass = "120"
      expect(@person.score).to eq(12)
    end
  end

  describe "#compare_to" do
    before(:each) do
      @primary = Person.new
      @primary.name = "Luke Skywalker"
      @primary.films = []
      @primary.vehicles = []
      @primary.starships = []
      @primary.height = 0
      @primary.mass = 0

      @secondary = Person.new
      @secondary.name = "Darth Vader"
      @secondary.films = []
      @secondary.vehicles = []
      @secondary.starships = []
      @secondary.height = 0
      @secondary.mass = 0
    end

    it "correctly picks a primary winner based on score" do
      @primary.mass = "1000"

      expect(@primary.compared_to(@secondary)["winner"]).to eq("Luke Skywalker")
    end

    it "correctly picks a secondary winner based on score" do
      @secondary.mass = "1000"

      expect(@primary.compared_to(@secondary)["winner"]).to eq("Darth Vader")
    end

    it "correctly picks a tie based on score" do
      @primary.mass = "1000"
      @secondary.mass = "1000"

      expect(@primary.compared_to(@secondary)["winner"]).to eq("It is a tie")
    end

    it "correctly titles the winner for mass as a strength" do
      @primary.mass = "1000"

      expect(@primary.compared_to(@secondary)["strengths"][0]).to eq("Luke Skywalker has more mass")
    end

    it "correctly titles the loser for mass as a strength" do
      @secondary.mass = "1000"

      expect(@primary.compared_to(@secondary)["weaknesses"][0]).to eq("Luke Skywalker has less mass")
    end
  end

end
