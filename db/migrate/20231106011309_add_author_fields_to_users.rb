class AddAuthorFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :website_url, :string
    add_column :users, :about, :text
    add_column :users, :social_links, :string, array: true, default: []
  end
end
