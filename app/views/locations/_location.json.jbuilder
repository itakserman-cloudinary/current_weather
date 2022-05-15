json.extract! location, :id, :city, :coutry_code, :lat, :lon, :created_at, :updated_at
json.url location_url(location, format: :json)
