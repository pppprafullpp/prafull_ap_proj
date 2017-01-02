class RenameColumnPlatformTypeIdToFacebookProfileId < ActiveRecord::Migration
  def change
    rename_column :social_accounts, :platform_type_id, :facebook_profile_id
  end
end
