require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    assign(:book, Book.create!(
      title: "Title",
      primary_link: "Primary Link",
      additional_links: "Additional Links",
      one_liner_blurb: "One Liner Blurb",
      description: "MyText",
      display_price: "Display Price",
      free: false,
      promo_active: false
    ))
  end

  xit "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Primary Link/)
    expect(rendered).to match(/Additional Links/)
    expect(rendered).to match(/One Liner Blurb/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Display Price/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
