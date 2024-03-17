class RemoveTagsFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :tags
  end
end
