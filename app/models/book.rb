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
#  tag_id           :bigint
#
# Indexes
#
#  index_books_on_tag_id  (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (tag_id => tags.id)
#
class Book < ApplicationRecord
  REQUIRED_ATTRIBUTES = %i[title display_price one_liner_blurb primary_link].freeze
  validates(*REQUIRED_ATTRIBUTES, presence: true)
  has_one :tag
  has_one_attached :cover_image
end
