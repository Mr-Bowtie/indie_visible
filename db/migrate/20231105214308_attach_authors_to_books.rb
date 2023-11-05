class AttachAuthorsToBooks < ActiveRecord::Migration[7.0]
  def change
    change_table :books do |t|
      t.belongs_to :author, index: true, foreign_key: { to_table: :users }
    end
  end
end
