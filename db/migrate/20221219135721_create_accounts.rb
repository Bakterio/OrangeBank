class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :curenccy
      t.integer :value
      t.references :owener, null: false, foreign_key: true

      t.timestamps
    end
  end
end
