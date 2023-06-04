class UserHasOneQrcodetransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :usrs, :transactionqrcode_id, :integer
    add_column :transactionqrcodes, :usr_id, :integer, null: false
    add_foreign_key :usrs, :transactionqrcodes
  end
end
