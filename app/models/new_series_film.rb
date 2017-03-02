class NewSeriesFilm < ApplicationRecord
  has_and_belongs_to_many :new_series_person
end
