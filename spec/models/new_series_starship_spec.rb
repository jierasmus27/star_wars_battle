require 'rails_helper'

RSpec.describe NewSeriesStarship, type: :model do
  it { is_expected.to have_and_belong_to_many(:new_series_people) }
  it { is_expected.to have_and_belong_to_many(:new_series_films) }
end
