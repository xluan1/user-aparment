class CreateUserAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :user_accounts do |t|
      t.references :user
      t.decimal :balance

      t.timestamps
    end
  end
end
