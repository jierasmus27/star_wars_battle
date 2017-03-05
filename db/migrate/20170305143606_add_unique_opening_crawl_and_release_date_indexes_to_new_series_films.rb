class AddUniqueOpeningCrawlAndReleaseDateIndexesToNewSeriesFilms < ActiveRecord::Migration[5.0]
  def change
    add_index :new_series_films, :release_date, :unique => true
    add_index :new_series_films, :opening_crawl, :unique => true
  end
end
