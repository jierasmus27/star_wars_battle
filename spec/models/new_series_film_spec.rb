require 'rails_helper'

RSpec.describe NewSeriesFilm, type: :model do
  describe 'relationships' do
    it { is_expected.to have_and_belong_to_many(:new_series_people) }
  end

  describe 'uniqueness' do
    it { is_expected.to validate_uniqueness_of(:episode_id) }
    it { is_expected.to validate_uniqueness_of(:opening_crawl) }
    it { is_expected.to validate_uniqueness_of(:release_date) }
  end
end
