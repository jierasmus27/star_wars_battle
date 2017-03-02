require 'rails_helper'

RSpec.describe NewSeriesPerson, type: :model do
  describe 'relationships' do
    it { is_expected.to have_and_belong_to_many(:new_series_films) }
  end
end
