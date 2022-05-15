class WeatherLog < ApplicationRecord
  include ExternalWeather
  
  belongs_to :location
  validates :temp, presence: true
  validates :latest, presence: true

  def get_weather_from_external_system
      request_url = "#{ENV["OPEN_WEATHER_BASE_URL"]}/#{ENV["OPEN_WEATHER_CURRENT_WEATHER_EXTENSION"]}"
      response = RestClient.get request_url, {
        content_type: :json, 
        accept: :json,
        params: {
            'lat' => self.location.lat,
            'lon' => self.location.lon,
            'appid' => ENV["OPEN_WEATHER_API_KEY"],
            'units' => 'metric'
        }
      }
      weather_data = JSON.parse(response.body)
      unless weather_data.nil?
        self.temp, self.latest = weather_data['main']['temp'], true
      end
  end
end
