require 'rails_helper'

RSpec.describe "books/edit", type: :view do
  let(:book) {
    Book.create!(
      title: "MyString",
      primary_link: "MyString",
      additional_links: "MyString",
      one_liner_blurb: "MyString",
      description: "MyText",
      display_price: "MyString",
      free: false,
      promo_active: false
    )
  }

  before(:each) do
    assign(:book, book)
  end

  it "renders the edit book form" do
    render

    assert_select "form[action=?][method=?]", book_path(book), "post" do

      assert_select "input[name=?]", "book[title]"

      assert_select "input[name=?]", "book[primary_link]"

      assert_select "input[name=?]", "book[additional_links]"

      assert_select "input[name=?]", "book[one_liner_blurb]"

      assert_select "textarea[name=?]", "book[description]"

      assert_select "input[name=?]", "book[display_price]"

      assert_select "input[name=?]", "book[free]"

      assert_select "input[name=?]", "book[promo_active]"
    end
  end
end
