class CreateJoinTableNewSeriesStarshipNewSeriesPerson < ActiveRecord::Migration[5.0]
  def change
    create_join_table :new_series_starships, :new_series_people do |t|
      # t.index [:new_series_starship_id, :new_series_person_id]
      # t.index [:new_series_person_id, :new_series_starship_id]
    end
  end
end
