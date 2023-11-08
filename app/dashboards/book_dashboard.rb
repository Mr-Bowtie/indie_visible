require "administrate/base_dashboard"

class BookDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    additional_links: Field::String,
    adult_content: Field::Boolean,
    description: Field::Text,
    display_price: Field::String,
    free: Field::Boolean,
    genres: Field::String,
    kindle_unlimited: Field::Boolean,
    one_liner_blurb: Field::String,
    primary_link: Field::Url,
    promo_active: Field::Boolean,
    queer_rep: Field::Boolean,
    tag: Field::BelongsTo,
    author: Field::BelongsTo,
    tags: Field::String,
    title: Field::String,
    trigger_warning: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    cover_image: Field::ActiveStorage,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    title
    author
    tag
    free
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    cover_image
    title
    description
    one_liner_blurb
    display_price
    primary_link
    adult_content
    free
    kindle_unlimited
    promo_active
    queer_rep
    author
    tag
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    cover_image
    additional_links
    adult_content
    description
    display_price
    free
    kindle_unlimited
    one_liner_blurb
    primary_link
    promo_active
    queer_rep
    tag
    title
    trigger_warning
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
