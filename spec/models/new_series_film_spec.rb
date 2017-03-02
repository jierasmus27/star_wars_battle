require 'rails_helper'

RSpec.describe NewSeriesFilm, type: :model do
  describe 'relationships' do
    it { is_expected.to have_and_belong_to_many(:new_series_person) }
  end
end
