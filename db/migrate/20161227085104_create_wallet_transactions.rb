class CreateWalletTransactions < ActiveRecord::Migration
  def change
    create_table :wallet_transactions do |t|
      t.integer :advertiser_id
      t.text :paypal_transaction_id
      t.integer :transaction_amount
      t.text :transaction_description

      t.timestamps null: false
    end
  end
end
