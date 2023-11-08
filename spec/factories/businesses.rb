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
    name { "MyString" }
    website_url { "MyString" }
  end
end
