class AddTriggerWarningToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :trigger_warning, :string, default: ''
  end
end
