class ChangeBooksAdultContentToSpicy < ActiveRecord::Migration[7.0]
  def change
    rename_column(:books, :adult_content, :spicy)
  end
end
