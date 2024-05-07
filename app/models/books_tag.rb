# == Schema Information
#
# Table name: books_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint
#  tag_id     :bigint
#
# Indexes
#
#  index_books_tags_on_book_id  (book_id)
#  index_books_tags_on_tag_id   (tag_id)
#
class BooksTag < ApplicationRecord
  belongs_to :book
  belongs_to :tag
end
