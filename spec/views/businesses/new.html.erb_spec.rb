require 'rails_helper'

RSpec.describe "businesses/new", type: :view do
  before(:each) do
    assign(:business, Business.new(
      name: "MyString",
      website_url: "MyString"
    ))
  end

  xit "renders new business form" do
    render

    assert_select "form[action=?][method=?]", businesses_path, "post" do

      assert_select "input[name=?]", "business[name]"

      assert_select "input[name=?]", "business[website_url]"
    end
  end
end
