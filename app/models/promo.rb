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
class Promo < ApplicationRecord
  has_one_attached :banner
  scope :next_up, lambda {
                    where(['start_date > :today', { today: Date.today }])
                      .order(:start_date)
                  }
  scope :active, lambda {
                   where(['start_date < :today and end_date > :today', { today: Date.today }])
                     .or(where(['start_date = :today', { today: Date.today }]))
                     .or(where(['end_date = :today', { today: Date.today }]))
                 }
end
