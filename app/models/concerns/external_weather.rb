module ExternalWeather 
    extend ActiveSupport::Concern
    
    class_methods do
        def get_weather_from_external_system(location)
            request_url = "#{ENV["OPEN_WEATHER_BASE_URL"]}/#{ENV["OPEN_WEATHER_CURRENT_WEATHER_EXTENSION"]}"
            response = RestClient.get request_url, {
              content_type: :json, 
              accept: :json,
              params: {
                  'lat' => location.lat,
                  'lon' => location.lon,
                  'appid' => ENV["OPEN_WEATHER_API_KEY"],
                  'units' => 'metric'
              }
            }
            weather_data = JSON.parse(response.body)
            unless weather_data.nil?
              WeatherLog.create(temp: weather_data['main']['temp'], latest: true)
            end
        end
    end
end