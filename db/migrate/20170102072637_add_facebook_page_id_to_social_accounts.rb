class AddFacebookPageIdToSocialAccounts < ActiveRecord::Migration
  def change
    add_column :social_accounts, :facebook_page_id, :text
  end
end
