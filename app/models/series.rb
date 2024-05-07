# == Schema Information
#
# Table name: series
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint
#
# Indexes
#
#  index_series_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#
class Series < ApplicationRecord
  has_many :books, dependent: :nullify
  belongs_to :author, class_name: 'User'
  validates :name, presence: true, uniqueness: { scope: :author_id }
end
