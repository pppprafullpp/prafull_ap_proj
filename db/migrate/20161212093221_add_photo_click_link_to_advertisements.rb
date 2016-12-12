class AddPhotoClickLinkToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :photo_click_link, :text
  end
end
