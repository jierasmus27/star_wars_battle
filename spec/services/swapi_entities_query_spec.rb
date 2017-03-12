require 'rails_helper'

RSpec.describe SwapiEntitiesQuery do
  let(:luke_skywalker_request_result) { create(:person_request, :luke_skywalker) }
  let(:sentinel_request_result) { create(:starship_request, :sentinel) }

  context "for People" do
    describe "#all" do
      before(:each) do
        Rails.cache.clear

        allow(SwapiRb::People).to receive(:all).and_return([luke_skywalker_request_result])
      end

      it "sets all attributes received" do
        people = SwapiEntitiesQuery.new(Person).call

        expect(people[0].name).to eq(luke_skywalker_request_result.name)
      end

      # it "sets the id attribute from the url" do
      #   people = SwapiEntitiesQuery.new(Person).call
      #
      #   expect(people[0].id).to eq(1)
      # end
    end
  end

  context "for Starships" do
    describe "#find_by_id" do
      before(:each) do
        Rails.cache.clear

        allow(SwapiRb::Starship).to receive(:all).and_return([sentinel_request_result])
      end

      it "sets all attributes received" do
        starships = SwapiEntitiesQuery.new(Starship).call

        expect(starships[0].name).to eq(sentinel_request_result.name)
      end

      # it "sets the id attribute from the url" do
      #   starships = SwapiEntitiesQuery.new(Starship).call
      #   byebug
      #
      #   expect(starships[0].id).to eq(5)
      # end
    end
  end
end
