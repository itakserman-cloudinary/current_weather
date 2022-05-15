module LocationFetcher
    extend ActiveSupport::Concern
    class_methods do
        def fetch(params)
            location = Location.where("city = ? AND coutry_code = ?", 
              params[:city], params[:coutry_code]).first
            if location.nil?
              location = Location.new(
                  coutry_code: params[:coutry_code],
                  city: params[:city]
              )
              location.save
            end
            location
          end
    end
end