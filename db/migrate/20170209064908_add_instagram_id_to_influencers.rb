class AddInstagramIdToInfluencers < ActiveRecord::Migration
  def change
    add_column :influencers, :instagram_id, :text
  end
end
