json.extract! place, :id, :name, :address, :lat, :lng, :street_number, :street, :city, :country, :created_at, :updated_at
json.url place_url(place, format: :json)
