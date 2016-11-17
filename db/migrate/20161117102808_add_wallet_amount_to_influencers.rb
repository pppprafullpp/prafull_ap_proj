class AddWalletAmountToInfluencers < ActiveRecord::Migration
  def change
    add_column :influencers, :wallet_amount, :integer
  end
end
