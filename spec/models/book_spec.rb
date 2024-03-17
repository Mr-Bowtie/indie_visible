# == Schema Information
#
# Table name: books
#
#  id               :bigint           not null, primary key
#  additional_links :string           default([]), is an Array
#  description      :text
#  display_price    :string
#  free             :boolean          default(FALSE)
#  kindle_unlimited :boolean          default(FALSE)
#  one_liner_blurb  :string
#  paperback_price  :string
#  position         :integer
#  primary_link     :string
#  promo_active     :boolean          default(FALSE)
#  queer_rep        :boolean          default(FALSE)
#  spicy            :boolean          default(FALSE)
#  title            :string
#  trigger_warning  :string           default("")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  author_id        :bigint
#  genre_id         :bigint
#  series_id        :bigint
#
# Indexes
#
#  index_books_on_author_id  (author_id)
#  index_books_on_genre_id   (genre_id)
#  index_books_on_series_id  (series_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (genre_id => genres.id)
#  fk_rails_...  (series_id => series.id)
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
