class AddGroupMappingIdToInfluencerGroups < ActiveRecord::Migration
  def change
    add_column :influencer_groups, :group_mapping_id, :integer
  end
end
