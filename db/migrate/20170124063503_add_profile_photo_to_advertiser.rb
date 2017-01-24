class AddProfilePhotoToAdvertiser < ActiveRecord::Migration
  def change
    add_column :advertisers, :profile_photo_url, :text
  end
end
