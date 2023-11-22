class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :name
      t.references :user_account, foreign_key: true

      t.timestamps
    end
  end
end
