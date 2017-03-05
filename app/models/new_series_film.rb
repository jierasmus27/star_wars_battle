class NewSeriesFilm < ApplicationRecord
  has_and_belongs_to_many :new_series_people

  validates_uniqueness_of :episode_id, :opening_crawl, :release_date
end
