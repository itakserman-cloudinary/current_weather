class RemoveLogTimeFromWeatherLogs < ActiveRecord::Migration[7.0]
  def change
    remove_column :weather_logs, :log_time, :datetime
  end
end
