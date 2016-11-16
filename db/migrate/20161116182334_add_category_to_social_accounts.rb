class AddCategoryToSocialAccounts < ActiveRecord::Migration
  def change
    add_column :social_accounts, :category, :text
  end
end
