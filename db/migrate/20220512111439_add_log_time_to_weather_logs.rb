class AddLogTimeToWeatherLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :weather_logs, :log_time, :datetime
  end
end
