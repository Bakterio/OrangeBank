class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :note, null: false
      t.string :my_note
      t.string :variable_symbol
      t.decimal :amount, precision: 18, scale: 2, null: false
      t.references :sender, null: false, foreign_key: true, foreign_key: {to_table: "accounts"}
      t.references :recipient, null: false, foreign_key: true, foreign_key: {to_table: "accounts"}

      t.timestamps
    end
  end
end
