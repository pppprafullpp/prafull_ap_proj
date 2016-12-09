class AddPlatformToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :platform, :integer
  end
end
