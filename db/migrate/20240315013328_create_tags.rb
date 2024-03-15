class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.color_index :integer

      t.timestamps
    end
  end
end
