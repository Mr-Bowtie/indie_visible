# frozen_string_literal: true

class Books::GalleryActivationCardComponent < ViewComponent::Base
  attr_accessor :book
  def initialize(book:)
    @book = book
  end
end
