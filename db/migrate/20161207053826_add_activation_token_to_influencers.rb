class AddActivationTokenToInfluencers < ActiveRecord::Migration
  def change
    add_column :influencers, :token, :text
  end
end
