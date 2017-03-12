require 'rails_helper'

RSpec.describe SwapiEntitiesQuery do
  let(:luke_skywalker_request_result) { create(:person_request, :luke_skywalker) }
  let(:sentinel_request_result) { create(:starship_request, :sentinel) }

  context "for People" do
    describe "#all" do
      before(:each) do
        Rails.cache.clear

        allow(SwapiRb::People).to receive(:find_by_id).with(1).and_return(luke_skywalker_request_result)
      end

      it "sets all attributes received" do
        person = SwapiEntityQuery.new(Person).find(1)

        expect(person.name).to eq(luke_skywalker_request_result.name)
      end
    end
  end

  context "for Starships" do
    describe "#all" do
      before(:each) do
        Rails.cache.clear

        allow(SwapiRb::Starship).to receive(:find_by_id).with(1).and_return(sentinel_request_result)
      end

      it "sets all attributes received" do
        starship = SwapiEntityQuery.new(Starship).find(1)

        expect(starship.name).to eq(sentinel_request_result.name)
      end
    end
  end
end
