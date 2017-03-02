class CreateJoinTableNewSeriesFilmNewSeriesPerson < ActiveRecord::Migration[5.0]
  def change
    create_join_table :new_series_films, :new_series_people do |t|
      # t.index [:new_series_film_id, :new_series_person_id]
      # t.index [:new_series_person_id, :new_series_film_id]
    end
  end
end
