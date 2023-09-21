# == Schema Information
#
# Table name: books
#
#  id               :bigint           not null, primary key
#  additional_links :string           default([]), is an Array
#  description      :text
#  display_price    :string
#  free             :boolean          default(FALSE)
#  genres           :string           default([]), is an Array
#  one_liner_blurb  :string
#  primary_link     :string
#  promo_active     :boolean          default(FALSE)
#  tags             :string           default([]), is an Array
#  title            :string
#  trigger_warning  :string           default("")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    primary_link { Faker::Internet.url }
    one_liner_blurb { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    display_price { Faker::Commerce.price }
    free { false }
    promo_active { false }
  end

  trait :has_tags do
    tags { Array.new(3) { Faker::Book.genre } }
  end

  trait :has_genres do
    genres { Array.new(3) { Faker::Book.genre } }
  end
end
