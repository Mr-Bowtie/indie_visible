# == Schema Information
#
# Table name: promos
#
#  id         :bigint           not null, primary key
#  end_date   :date
#  start_date :date
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :promo do
    title { "MyString" }
    start_date { "2023-11-14" }
    end_date { "2023-11-14" }
  end
end
