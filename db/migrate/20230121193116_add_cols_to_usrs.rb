class AddColsToUsrs < ActiveRecord::Migration[7.0]
  def change
    add_column :usrs, :first_name, :string, null: false
    add_column :usrs, :last_name, :string, null: false
    add_column :usrs, :admin, :boolean, default: false, null: false
  end
end
