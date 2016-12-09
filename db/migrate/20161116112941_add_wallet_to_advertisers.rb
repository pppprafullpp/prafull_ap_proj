class AddWalletToAdvertisers < ActiveRecord::Migration
  def change
    add_column :advertisers, :wallet_amount, :integer
  end
end
