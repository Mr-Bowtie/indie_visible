json.extract! business, :id, :name, :website_url, :created_at, :updated_at
json.url business_url(business, format: :json)
