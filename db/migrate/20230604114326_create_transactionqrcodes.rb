class CreateTransactionqrcodes < ActiveRecord::Migration[7.0]
  def change
    create_table :transactionqrcodes do |t|

      t.timestamps
      t.string :link, null: false
    end
  end
end
