class AddIsVerifiedToInfluencers < ActiveRecord::Migration
  def change
    add_column :influencers, :is_verified, :boolean
  end
end
