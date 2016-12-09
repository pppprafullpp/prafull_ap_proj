class AddFacebookImageUrlToSocialAccounts < ActiveRecord::Migration
  def change
    add_column :social_accounts, :facebook_image_url, :text
  end
end
