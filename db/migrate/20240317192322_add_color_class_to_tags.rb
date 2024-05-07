class AddColorClassToTags < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :color_class, :integer
  end
end
