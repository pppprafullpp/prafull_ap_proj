class AddLikesToSocialAccounts < ActiveRecord::Migration
  def change
    add_column :social_accounts, :facebook_page_count, :integer
    add_column :social_accounts, :instagram_page_count, :integer
  end
end
