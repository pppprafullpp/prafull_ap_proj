class AddInfluencerIdToAdvetisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :advertiser_id, :integer
    add_column :advertisements, :influencer_id, :integer
  end
end
