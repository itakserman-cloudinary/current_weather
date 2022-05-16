require "rails_helper"

RSpec.describe UserLocationSetting, :type => :model do
    describe ".current_weather" do
        let(:current_time) { Time.now }
        let(:user) { User.create(:email => "email@mock.com", :first_name => "mick", :last_name => "mock", :avatar => "some_image_url") }
        let(:location) { Location.create(:city => "Raanana", :coutry_code => "IL", :lat => 0.321861481e2, :lon => 0.348675905e2) }
        let(:user_location_setting) {user.user_location_settings.create(:cache_ttl => 600, :name => "mock_name", :location => location)}
        let(:weather_log_old) {location.weather_logs.create(:temp => 26.6, :latest => true, :created_at => current_time - 60 * 60, :updated_at => current_time)}
        let(:weather_log_new) {location.weather_logs.create(:temp => 24.6, :latest => true, :created_at => current_time, :updated_at => current_time)}

        before do
            user
            location
            user_location_setting
            weather_log_old
            weather_log_new
            location.unset_latest_for_old_weather_logs(current_time)
        end

        it "unset_latest_for_old_weather_logs updates latest to false" do
            old_logs = location.weather_logs.where(latest: false)
            expect(old_logs.empty?).to eql false
        end

        it "unset_latest_for_new_weather_logs keeps latest true" do
            new_logs = location.weather_logs.where(latest: true)
            expect(new_logs.empty?).to eql false
        end

        it "get_current_weather_returns_current" do
            current_weather = user_location_setting.get_current_weather
            expect(current_weather.id).to eq weather_log_new.id
        end
    end
end