# == Schema Information
#
# Table name: tags
#
#  id          :bigint           not null, primary key
#  color_class :integer
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Tag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
