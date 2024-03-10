class AssociateBooksWithSeries < ActiveRecord::Migration[7.0]
  def change
    change_table :books do |t|
      t.belongs_to :series, index: true, foreign_key: true
    end
  end
end
