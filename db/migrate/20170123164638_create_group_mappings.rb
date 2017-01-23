class CreateGroupMappings < ActiveRecord::Migration
  def change
    create_table :group_mappings do |t|
      t.integer :advertiser_id
      t.integer :influencer_group_id

      t.timestamps null: false
    end
  end
end
