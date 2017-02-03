class AddFacebookPageTitleToSocialAccount < ActiveRecord::Migration
  def change
    add_column :social_accounts, :facebook_page_title, :text
  end
end
