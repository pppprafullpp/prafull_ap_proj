class AddAdvertiserTypeToAdvertisers < ActiveRecord::Migration
  def change
    add_column :advertisers, :advertiser_type, :string
  end
end
