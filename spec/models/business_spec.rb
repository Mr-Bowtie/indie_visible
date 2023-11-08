# == Schema Information
#
# Table name: businesses
#
#  id          :bigint           not null, primary key
#  name        :string
#  website_url :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Business, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
