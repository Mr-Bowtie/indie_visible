json.extract! book, :id, :title, :primary_link, :additional_links, :one_liner_blurb, :description, :display_price, :free, :promo_active, :created_at, :updated_at
json.url book_url(book, format: :json)
