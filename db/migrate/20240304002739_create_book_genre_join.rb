class CreateBookGenreJoin < ActiveRecord::Migration[7.0]
  def change
    create_table :books_genres, id: false do |t|
      t.belongs_to :genre
      t.belongs_to :book
    end
  end
end
