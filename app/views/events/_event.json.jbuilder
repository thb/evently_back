json.extract! event, :id, :name, :description, :place_id, :category_id, :occurs_at, :created_at, :updated_at
json.url event_url(event, format: :json)
