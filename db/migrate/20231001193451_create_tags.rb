class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    change_table :books do |t|
      t.belongs_to :tag, foreign_key: true
    end
  end
end
