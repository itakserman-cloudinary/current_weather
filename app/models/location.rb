class Location < ApplicationRecord
    include LocationFetcher

    has_many :weather_logs
    has_many :user_location_settings
    has_many :users, through: :user_location_settings

    before_validation :get_coordinates_from_external_system
    
    validates :city, presence: true
    validates :lat, presence: true
    validates :lon, presence: true
    validates :coutry_code, presence: true
    validate :country_code_exists
    
    after_validation :format_params

    
    def unset_latest_for_old_weather_logs(created_at)
        old_records = self.weather_logs.where("created_at <  ? and latest = true", created_at)
        old_records.each do |old_record|
            old_record.update_attribute(:latest, false)
        end
    end

    private
        def country_code_exists
            c = ISO3166::Country.find_country_by_alpha2(coutry_code)
            if c.nil?
                errors.add(:coutry_code, "must be valid")
            end
        end

        def format_params
            self.coutry_code = coutry_code.downcase
            self.city = city.downcase
        end

        def get_coordinates_from_external_system
            request_url = "#{ENV["OPEN_WEATHER_BASE_URL"]}/#{ENV["OPEN_WEATHER_GEO_LOCATION_EXTENSION"]}"
            response = RestClient.get request_url, {
            content_type: :json, 
            accept: :json,
            params: {
                'q' => "#{self.city},,#{self.coutry_code}",
                'limit' => 1,
                'appid' => ENV["OPEN_WEATHER_API_KEY"]
            }}
            location_data = JSON.parse(response.body)
            external_location = location_data.first if location_data.kind_of?(Array)
            unless external_location.nil?
                self.lat, self.lon = external_location["lat"], external_location["lon"]
            end
        end
end
