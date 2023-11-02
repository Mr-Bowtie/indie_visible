class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :primary_link
      t.string :additional_links, array: true, default: []
      t.string :one_liner_blurb
      t.text :description
      t.string :display_price
      t.boolean :free, default: false
      t.boolean :promo_active, default: false
      t.string :genres, array: true, default: []
      t.string :tags, array: true, default: []

      t.timestamps
    end
  end
end
