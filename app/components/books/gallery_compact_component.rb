# frozen_string_literal: true

class Books::GalleryCompactComponent < ViewComponent::Base
  attr_accessor :book

  def initialize(book:)
    @book = book
  end
end
