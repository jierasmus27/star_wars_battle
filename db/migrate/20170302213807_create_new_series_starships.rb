class CreateNewSeriesStarships < ActiveRecord::Migration[5.0]
  def change
    create_table :new_series_starships do |t|
      t.string :name
      t.string :model
      t.string :manufacturer
      t.integer :cost_in_credits
      t.integer :length
      t.string :max_atmospheric_speec
      t.integer :crew
      t.integer :passengers
      t.integer :cargo_capacity
      t.string :consumables
      t.string :hyperdrive_rating
      t.integer :MGLT
      t.string :starship_class
      t.references :new_series_people, foreign_key: true
      t.references :new_series_films, foreign_key: true

      t.timestamps
    end
  end
end
