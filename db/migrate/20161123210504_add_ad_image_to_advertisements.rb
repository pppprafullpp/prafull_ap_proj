class AddAdImageToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :ad_image_url, :text
  end
end
