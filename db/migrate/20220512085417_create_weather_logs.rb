class CreateWeatherLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :weather_logs do |t|
      t.decimal :temp, precision: 6, scale: 2
      t.boolean :latest
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
