class AccountValueDouble < ActiveRecord::Migration[7.0]
  def change
    remove_column :accounts, :value
    add_column :accounts, :value, :decimal, precision: 18, scale: 2, null: false, default: 0
  end
end
