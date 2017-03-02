class CreateNewSeriesFilms < ActiveRecord::Migration[5.0]
  def change
    create_table :new_series_films do |t|
      t.integer :episode_id
      t.string :opening_crawl
      t.string :director
      t.string :producer
      t.datetime :release_date
      t.references :new_series_person, foreign_key: true

      t.timestamps
    end
  end
end
