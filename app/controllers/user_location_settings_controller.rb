class UserLocationSettingsController < ApplicationController

    # POST /user_location_settings or /user_location_settings.json
    def create
        @user = User.find(params[:user_id])
        location = Location.fetch(fetch_location_params)
        @user_location_setting = @user.user_location_settings.new(user_location_setting_params)
        @user_location_setting.location = location
        @user_location_setting.save
        redirect_to user_path(@user)
    end
    
    def destroy
        @user = User.find(params[:user_id])
        @user_location_setting = @user.user_location_settings.find(params[:id])
        @user_location_setting.destroy
        redirect_to user_path(@user), status: 303
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_user_location_setting
            @user_location_setting = UserLocationSetting.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def user_location_setting_form_params
            params.require(:user_location_setting).permit(:cache_ttl, :name, :city, :coutry_code)
        end

        def user_location_setting_params
            user_location_setting_form_params.extract!(:cache_ttl, :name)
        end

        def fetch_location_params
            user_location_setting_form_params.extract!(:city, :coutry_code)
        end

end
