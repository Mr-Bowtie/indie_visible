class ChangeBooksTagToGenre < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :genres
    rename_column :books, :tag_id, :genre_id
    rename_table :tags, :genres
  end
end
