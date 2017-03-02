class CreateNewSeriesPeople < ActiveRecord::Migration[5.0]
  def change
    create_table :new_series_people do |t|
      t.string :name
      t.integer :height
      t.integer :mass
      t.string :hair_color
      t.string :skin_color
      t.string :eye_color
      t.string :birth_year
      t.string :gender

      t.timestamps
    end
  end
end
