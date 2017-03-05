class RemoveNewSeriesPersonIdFromNewSeriesFilm < ActiveRecord::Migration[5.0]
  def change
    remove_column :new_series_films, :new_series_person_id, :integer
  end
end
