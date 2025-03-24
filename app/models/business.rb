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
class Business < ApplicationRecord
  has_one_attached :logo_image
  validates :name, presence: true
  validates :website_url, presence: true

  def process_logo_variants
    logo.variants(resize_to_limit: [400, 400]).processed
  end
end
