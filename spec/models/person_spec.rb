require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:luke_skywalker_request_result) { create(:person_request, :luke_skywalker) }

  describe "#find_by_id" do
    before(:each) do
      Rails.cache.clear

      allow(SwapiRb::People).to receive(:find_by_id).with(1).and_return(luke_skywalker_request_result)
    end

    it "sets all attributes received" do
      person_result = SwapiEntityQuery.new(Person).find(1)
      person = Person.new(person_result)

      expect(person.name).to eq(luke_skywalker_request_result.name)
    end

    it "sets the id attribute from the url" do
      person_result = SwapiEntityQuery.new(Person).find(1)
      person = Person.new(person_result)

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

      allow(SwapiRb::People).to receive(:find_by_id).with(1).and_return(luke_skywalker_request_result)
    end

    it "assigns one point for each film the character was in" do
      @person.films = ["A New Hope", "The Force Awakens"]

      expect(@person.score).to eq(2)
    end

    it "assigns two points per vehicle" do
      @person.vehicles = ["AT-AT"]

      expect(@person.score).to eq(2)
    end

    it "assigns two points per starship" do
      @person.starships = ["Millennium Falcon"]

      expect(@person.score).to eq(2)
    end

    it "assigns points for height" do
      @person.height = "170"

      expect(@person.score).to eq(3)
    end

    it "assigns points for mass" do
      @person.mass = "120"

      expect(@person.score).to eq(3)
    end

    it "assigns accumulates points for all values" do
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

  describe "Comparison" do
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

    it "successfully implements the spaceship for the primary having a better score" do
      @primary.mass = "1000"

      expect(@primary > @secondary).to be(true)
    end

    it "successfully implements the spaceship for the secondary having a better score" do
      @secondary.mass = "1000"

      expect(@primary < @secondary).to be(true)
    end

    it "successfully implements the spaceship for the primary and secondary being equal" do
      @primary.mass = "1000"
      @secondary.mass = "1000"

      expect(@primary == @secondary).to be(true)
    end
  end

end
