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
#  position         :integer
#  primary_link     :string
#  promo_active     :boolean          default(FALSE)
#  queer_rep        :boolean          default(FALSE)
#  spicy            :boolean          default(FALSE)
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
  validates :position, numericality: { only_integer: true }, uniqueness: { scope: :series_id }, allow_blank: true
  validates :position, presence: true, if: -> { series_id.present? }
  validates :series_id, presence: true, if: -> { position.present? }
  has_and_belongs_to_many :genres
  has_many :books_tags, dependent: :nullify
  has_many :tags, through: :books_tags
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
  scope :filter_by_tag, lambda { |tag_ids|
    where(id:
      Book.joins(:tags)
      .merge(Tag.where(id: tag_ids))
      .group('books.id')
      .having('COUNT(tags.id) = ?', tag_ids.length)
      .select('books.id'))
  }
  scope :free, -> { joins(:tags).merge(Tag.where(name: %w[free Free])) }
  scope :promo_active_per_author, ->(author_id) { where(author_id:, promo_active: true) }
  scope :series_ordered, -> { left_joins(:series).order('series.name ASC', 'position ASC') }

  def ready_for_promo?
    PROMO_REQUIRED_ATTRIBUTES.all? { |attr| send(attr).present? } &&
      cover_image.attached?
  end

  def self.ransackable_attributes(_auth_object = nil)
    ['title']
  end

  def free?
    tags.select { |tag| tag.name.downcase == 'free' }.size == 1
  end

  def process_image_variants
    return unless cover_image.attached?

    cover_image.variant(resize_to_limit: [250, 250]).processed
    cover_image.variant(resize_to_limit: [500, 500]).processed
  end
end
