class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :city
      t.string :coutry_code
      t.decimal :lat, precision: 20, scale: 8
      t.decimal :lon, precision: 20, scale: 8

      t.timestamps
    end
  end
end
