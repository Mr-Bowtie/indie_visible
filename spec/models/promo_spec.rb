# == Schema Information
#
# Table name: promos
#
#  id         :bigint           not null, primary key
#  end_date   :date
#  start_date :date
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Promo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
