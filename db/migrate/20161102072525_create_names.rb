class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.integer :category_id
      t.integer :influencer_id
      t.integer :advertiser_id

      t.timestamps null: false
    end
  end
end
