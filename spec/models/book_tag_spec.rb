# == Schema Information
#
# Table name: book_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint
#  tag_id     :bigint
#
# Indexes
#
#  index_book_tags_on_book_id  (book_id)
#  index_book_tags_on_tag_id   (tag_id)
#
require 'rails_helper'

RSpec.describe BookTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
