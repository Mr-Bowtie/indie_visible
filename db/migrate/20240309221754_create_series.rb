class CreateSeries < ActiveRecord::Migration[7.0]
  def change
    create_table :series do |t|
      t.string :name
      t.belongs_to :author, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
