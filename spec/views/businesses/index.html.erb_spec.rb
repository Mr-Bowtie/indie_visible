require 'rails_helper'

RSpec.describe "businesses/index", type: :view do
  before(:each) do
    assign(:businesses, [
      Business.create!(
        name: "Name",
        website_url: "Website Url"
      ),
      Business.create!(
        name: "Name",
        website_url: "Website Url"
      )
    ])
  end

  it "renders a list of businesses" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Website Url".to_s), count: 2
  end
end
