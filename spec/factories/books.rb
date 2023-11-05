# == Schema Information
#
# Table name: books
#
#  id               :bigint           not null, primary key
#  additional_links :string           default([]), is an Array
#  adult_content    :boolean          default(FALSE)
#  description      :text
#  display_price    :string
#  free             :boolean          default(FALSE)
#  genres           :string           default([]), is an Array
#  kindle_unlimited :boolean          default(FALSE)
#  one_liner_blurb  :string
#  primary_link     :string
#  promo_active     :boolean          default(FALSE)
#  queer_rep        :boolean          default(FALSE)
#  tags             :string           default([]), is an Array
#  title            :string
#  trigger_warning  :string           default("")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  author_id        :bigint
#  tag_id           :bigint
#
# Indexes
#
#  index_books_on_author_id  (author_id)
#  index_books_on_tag_id     (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (tag_id => tags.id)
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
    tag { Tag.all.sample }

    after(:build) do |book|
      book.cover_image.attach(
        io: File.open(Rails.root.join('public','generic_cover.png')),
        filename: 'generic_cover.png',
        content_type: 'image/png'
      )
    end

  end

  trait :has_tags do
    tags { Array.new(3) { Faker::Book.genre } }
  end

  trait :has_genres do
    genres { Array.new(3) { Faker::Book.genre } }
  end

  trait :has_flags do
    booleans = [true, false]
    adult_content { booleans.sample }
    kindle_unlimited { booleans.sample }
    queer_rep { booleans.sample }
  end
end
