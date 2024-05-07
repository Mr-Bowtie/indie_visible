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
class Tag < ApplicationRecord
  has_many :books_tags, dependent: :nullify
  has_many :books, through: :books_tags
  # INFO: These names correspond to the Bulma text color class presets
  # INFO: They will be updated by the associated scss variable in application.scss
  # TODO: setup system to allow colors to be changed in admin
  enum color_class: { primary: 1, link: 2, info: 3, warning: 4, danger: 5 }
end
