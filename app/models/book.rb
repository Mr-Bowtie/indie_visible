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
class Book < ApplicationRecord
  REQUIRED_ATTRIBUTES = %i[title display_price one_liner_blurb primary_link].freeze
  validates(*REQUIRED_ATTRIBUTES, presence: true)
end
