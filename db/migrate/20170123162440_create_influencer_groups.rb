class CreateInfluencerGroups < ActiveRecord::Migration
  def change
    create_table :influencer_groups do |t|
      t.integer :advertiser_id
      t.string :influencer_id
      t.text :group_name

      t.timestamps null: false
    end
  end
end
