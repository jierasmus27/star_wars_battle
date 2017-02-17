require 'rails_helper'

RSpec.describe Starship, type: :model do
  let(:sentinel_request_result) { create(:starship_request, :sentinel) }

  describe "#find_by_id" do
    before(:each) do
      Rails.cache.clear

      allow(SwapiRb::Starship).to receive(:find_by_id).with(5).and_return(sentinel_request_result)
    end

    it "sets all attributes received" do
      starship = Starship.find_by_id(5)

      expect(starship.name).to eq(sentinel_request_result.name)
    end

    it "sets the id attribute from the url" do
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
      @starship.length = "100"

      expect(@starship.score).to eq(100)
    end

    it "assigns its crew in points" do
      @starship.crew = "200"

      expect(@starship.score).to eq(200)
    end

    it "assigns its max atmospheric speed in points" do
      @starship.max_atmosphering_speed = "2"

      expect(@starship.score).to eq(2)
    end

    it "assigns hyperdrive_rating in points" do
      @starship.hyperdrive_rating = "20"

      expect(@starship.score).to eq(20)
    end

    it "assigns points for passengers" do
      @starship.passengers = "10"

      expect(@starship.score).to eq(10)
    end

    it "assigns points for cargo_capacity" do
      @starship.cargo_capacity = "10"

      expect(@starship.score).to eq(10)
    end

    it "assigns accumulates points for all values" do
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

      expect(@primary.compared_to(@secondary)["winner"]).to eq(@primary.name)
    end

    it "correctly picks a secondary winner based on score" do
      @secondary.passengers = "1000"

      expect(@primary.compared_to(@secondary)["winner"]).to eq(@secondary.name)
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

end
