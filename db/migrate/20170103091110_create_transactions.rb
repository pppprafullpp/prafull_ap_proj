class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :advertisement_id
      t.integer :influencer_id
      t.integer :advertiser_id
      t.text :amount
      t.integer :status

      t.timestamps null: false
    end
  end
end
