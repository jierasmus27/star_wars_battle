class NewSeriesStarship < ApplicationRecord
  has_and_belongs_to_many :new_series_people
  has_and_belongs_to_many :new_series_films
end
