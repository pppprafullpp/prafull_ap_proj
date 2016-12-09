class AddActivationTokenToAdvertisers < ActiveRecord::Migration
  def change
    add_column :advertisers, :token, :text
  end
end
