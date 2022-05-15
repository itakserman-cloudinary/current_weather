class UserLocationSetting < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :weather_logs, through: :location
  
  validates :name, presence: true
  before_save :default_values
  after_destroy :destroy_detouched_location

  def default_values
    self.cache_ttl ||= 14400 # 4 hours default 
  end

  def get_current_weather
    weather_logs = self.location.weather_logs
    current_weather_logs = weather_logs.where(latest: true) 
    current_latest = current_weather_logs.first unless current_weather_logs.nil?
    if current_latest.nil? || current_latest.created_at + self.cache_ttl < Time.now     # This current set on local time!!!!
      new_latest = self.location.weather_logs.new
      new_latest.get_weather_from_external_system
      new_latest.save
      self.location.unset_latest_for_old_weather_logs(new_latest.created_at)
      new_latest
    else
      current_latest
    end
  end

  private
    def destroy_detouched_location
      self.location.destroy if self.location.user_location_settings.empty?
    end
end
