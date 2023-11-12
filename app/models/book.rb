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
#
# Indexes
#
#  index_books_on_author_id  (author_id)
#  index_books_on_genre_id   (genre_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (genre_id => genres.id)
#
class Book < ApplicationRecord
  REQUIRED_ATTRIBUTES = %i[title display_price one_liner_blurb primary_link].freeze
  validates(*REQUIRED_ATTRIBUTES, presence: true)
  belongs_to :genre
  belongs_to :author, class_name: 'User'
  has_one_attached :cover_image

  scope :filter_by_genre, ->(genre_id) { where('genre_id = ?', genre_id) }
  scope :kindle_unlimited, -> { where('kindle_unlimited = true') }
  scope :queer_rep, -> { where('queer_rep = true') }
  scope :spicy, -> { where('spicy = true') }
end
