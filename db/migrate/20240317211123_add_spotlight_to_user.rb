class AddSpotlightToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :spotlight, :boolean
  end
end
