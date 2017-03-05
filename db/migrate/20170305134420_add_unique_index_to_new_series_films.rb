class AddUniqueIndexToNewSeriesFilms < ActiveRecord::Migration[5.0]
  def change
    add_index :new_series_films, :episode_id, :unique => true
  end
end
