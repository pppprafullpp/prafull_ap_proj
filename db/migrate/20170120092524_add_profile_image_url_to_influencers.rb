class AddProfileImageUrlToInfluencers < ActiveRecord::Migration
  def change
    add_column :influencers, :profile_image_url, :text
  end
end
