require 'administrate/base_dashboard'

class BookDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    position: Field::Number,
    additional_links: Field::String,
    description: Field::Text,
    display_price: Field::String,
    paperback_price: Field::String,
    one_liner_blurb: Field::String,
    primary_link: Field::Url,
    promo_active: Field::Boolean,
    genres: Field::HasMany,
    author: Field::BelongsTo.with_options(searchable: true, searchable_fields: ['name']),
    series: Field::BelongsTo.with_options(searchable: true, searchable_fields: ['name']),
    title: Field::String,
    trigger_warning: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    cover_image: Field::ActiveStorage,
    tags: Field::HasMany,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    title
    series
    position
    promo_active
    author
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    cover_image
    title
    series
    position
    description
    one_liner_blurb
    display_price
    paperback_price
    primary_link
    promo_active
    author
    genres
    tags
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how books are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(book)
  #   "Book ##{book.id}"
  # end
end
