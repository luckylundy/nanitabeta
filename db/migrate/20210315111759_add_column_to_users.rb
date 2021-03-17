class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :portrait, :string, default: ""
  end
end
