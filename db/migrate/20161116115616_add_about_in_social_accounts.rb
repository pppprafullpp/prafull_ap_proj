class AddAboutInSocialAccounts < ActiveRecord::Migration
  def change
    add_column :social_accounts, :about, :text
  end
end
