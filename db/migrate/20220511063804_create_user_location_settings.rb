class CreateUserLocationSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :user_location_settings do |t|
      t.integer :cache_ttl
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
