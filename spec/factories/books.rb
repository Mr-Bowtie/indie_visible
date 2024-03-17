# == Schema Information
#
# Table name: books
#
#  id               :bigint           not null, primary key
#  additional_links :string           default([]), is an Array
#  description      :text
#  display_price    :string
#  free             :boolean          default(FALSE)
#  kindle_unlimited :boolean          default(FALSE)
#  one_liner_blurb  :string
#  paperback_price  :string
#  position         :integer
#  primary_link     :string
#  promo_active     :boolean          default(FALSE)
#  queer_rep        :boolean          default(FALSE)
#  spicy            :boolean          default(FALSE)
#  tags             :string           default([]), is an Array
#  title            :string
#  trigger_warning  :string           default("")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  author_id        :bigint
#  genre_id         :bigint
#  series_id        :bigint
#
# Indexes
#
#  index_books_on_author_id  (author_id)
#  index_books_on_genre_id   (genre_id)
#  index_books_on_series_id  (series_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (genre_id => genres.id)
#  fk_rails_...  (series_id => series.id)
#
FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    primary_link { Faker::Internet.url }
    one_liner_blurb { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraphs(number: rand(2..10)).join(' ') }
    display_price { Faker::Commerce.price }
    free { false }
    promo_active { false }
    author { User.where(role: 'author').sample }

    after(:build) do |book|
      book.cover_image.attach(
        io: File.open(Rails.root.join('public/generic_cover.png')),
        filename: 'generic_cover.png',
        content_type: 'image/png'
      )

      genre_ids = []
      rand(1..3).times do
        genre_ids << Genre.all.sample.id
      end

      genre_ids.uniq.each do |id|
        book.genres << Genre.find(id)
      end
    end
  end

  trait :has_genres do
    genres { Array.new(3) { Faker::Book.genre } }
  end

  trait :has_flags do
    booleans = [true, false]
    spicy { booleans.sample }
    kindle_unlimited { booleans.sample }
    queer_rep { booleans.sample }
    free { booleans.sample }
  end

  trait :has_tags do
    after(:build) do |book|
      tag_ids = []
      rand(1..4).times do
        tag_ids << Tag.all.sample.id
      end

      tag_ids.uniq.each do |id|
        book.tags << Tag.find(id)
      end
    end
  end

  trait :part_of_series do
    after(:build) do |book|
      series = Series.all.sample
      last_book = series.books.order(:position).last
      author_id = User.find(series.author_id).id
      next_position = last_book.nil? ? 1 : last_book.position + 1
      book.update(series_id: series.id, author_id: author_id, position: next_position)
    end
  end
end
