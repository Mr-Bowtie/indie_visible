require 'rails_helper'

RSpec.describe "businesses/show", type: :view do
  before(:each) do
    assign(:business, Business.create!(
      name: "Name",
      website_url: "Website Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Website Url/)
  end
end
