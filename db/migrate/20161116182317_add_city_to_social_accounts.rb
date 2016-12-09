class AddCityToSocialAccounts < ActiveRecord::Migration
  def change
    add_column :social_accounts, :city, :text
  end
end
