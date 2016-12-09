class AddIsVerifiedToAdvertisers < ActiveRecord::Migration
  def change
    add_column :advertisers, :is_verified, :boolean
  end
end
