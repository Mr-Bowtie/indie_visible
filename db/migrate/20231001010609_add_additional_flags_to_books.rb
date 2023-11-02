class AddAdditionalFlagsToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :kindle_unlimited, :boolean, default: false
    add_column :books, :queer_rep, :boolean, default: false
    add_column :books, :adult_content, :boolean, default: false
  end
end
