require 'rails_helper'

RSpec.describe "businesses/edit", type: :view do
  let(:business) {
    Business.create!(
      name: "MyString",
      website_url: "MyString"
    )
  }

  before(:each) do
    assign(:business, business)
  end

  xit "renders the edit business form" do
    render

    assert_select "form[action=?][method=?]", business_path(business), "post" do

      assert_select "input[name=?]", "business[name]"

      assert_select "input[name=?]", "business[website_url]"
    end
  end
end
