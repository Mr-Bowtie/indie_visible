require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        title: "Title",
        primary_link: "Primary Link",
        additional_links: "Additional Links",
        one_liner_blurb: "One Liner Blurb",
        description: "MyText",
        display_price: "Display Price",
        free: false,
        promo_active: false
      ),
      Book.create!(
        title: "Title",
        primary_link: "Primary Link",
        additional_links: "Additional Links",
        one_liner_blurb: "One Liner Blurb",
        description: "MyText",
        display_price: "Display Price",
        free: false,
        promo_active: false
      )
    ])
  end

  xit "renders a list of books" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Primary Link".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Additional Links".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("One Liner Blurb".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Display Price".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end
