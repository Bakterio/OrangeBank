class RenameUserIdCol < ActiveRecord::Migration[7.0]
  def change
    rename_column :accounts, :user_id, :usr_id
    remove_foreign_key :accounts, :users
    add_foreign_key :accounts, :usrs
  end
end
