# frozen_string_literal: true

class Books::GalleryQuickViewComponent < ViewComponent::Base
  attr_accessor :book
  def initialize(book:)
    @book = book
  end
end
