# frozen_string_literal: true

class Authors::SearchCardComponent < ViewComponent::Base
  attr_accessor :author

  def initialize(author:)
    @author = author
  end
end
