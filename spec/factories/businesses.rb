# == Schema Information
#
# Table name: businesses
#
#  id          :bigint           not null, primary key
#  name        :string
#  website_url :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :business do
    name { 'Winter Biz' }
    website_url { Faker::Internet.url }
    after(:build) do |business|
      business.logo_image.attach(
        io: File.open(Rails.root.join('public/biz_placeholder.png')),
        filename: 'user_image_placeholder.png',
        content_type: 'image/png'
      )
    end
  end
end
