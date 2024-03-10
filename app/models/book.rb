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
class Book < ApplicationRecord
  REQUIRED_ATTRIBUTES = %i[title display_price one_liner_blurb primary_link].freeze
  PROMO_REQUIRED_ATTRIBUTES = %i[title display_price one_liner_blurb primary_link genre_id author_id].freeze
  validates(*REQUIRED_ATTRIBUTES, presence: true)
  validates :cover_image, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  has_and_belongs_to_many :genres
  belongs_to :author, class_name: 'User'
  belongs_to :series, optional: true
  has_one_attached :cover_image

  scope :filter_by_genre, lambda { |genre_ids|
    where(id:
      Book.joins(:genres)
      .where(genres: { id: genre_ids })
      .group('books.id')
      .having('COUNT(genres.id) = ?', genre_ids.length)
      .select('books.id'))
  }
  scope :kindle_unlimited, -> { where('kindle_unlimited = true') }
  scope :queer_rep, -> { where('queer_rep = true') }
  scope :spicy, -> { where('spicy = true') }
  scope :not_spicy, -> { where('spicy = false') }
  scope :free, -> { where('free = true') }
  scope :promo_active_per_author, ->(author_id) { where(author_id:, promo_active: true) }

  def ready_for_promo?
    PROMO_REQUIRED_ATTRIBUTES.all? { |attr| send(attr).present? } &&
      cover_image.attached?
  end

  def self.ransackable_attributes(_auth_object = nil)
    ['title']
  end
end
