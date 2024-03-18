# == Schema Information
#
# Table name: tags
#
#  id          :bigint           not null, primary key
#  color_class :integer
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :tag do
    name { Faker::Adjective.positive }
    color_class { rand(1..5) }
  end

  trait :free do
    name { 'free' }
  end
end
