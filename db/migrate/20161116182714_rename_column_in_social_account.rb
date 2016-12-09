class RenameColumnInSocialAccount < ActiveRecord::Migration
  def change
    rename_column :social_accounts, :city, :country
  end
end
