# == Schema Information
#
# Table name: books
#
#  id               :bigint           not null, primary key
#  additional_links :string           default([]), is an Array
#  adult_content    :boolean          default(FALSE)
#  description      :text
#  display_price    :string
#  free             :boolean          default(FALSE)
#  genres           :string           default([]), is an Array
#  kindle_unlimited :boolean          default(FALSE)
#  one_liner_blurb  :string
#  primary_link     :string
#  promo_active     :boolean          default(FALSE)
#  queer_rep        :boolean          default(FALSE)
#  tags             :string           default([]), is an Array
#  title            :string
#  trigger_warning  :string           default("")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'with valid arguments' do
    it 'successfully saves a new instance' do
      book = build(:book)
      expect(book.save).to be true
    end
  end

  context 'with invalid arguments' do
    it 'does not save without required arguments' do
      book = Book.new
      expect(book.save).to be false
    end
  end
end
