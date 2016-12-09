class RenameTypeToAdTypeInAdvertisement < ActiveRecord::Migration
  def change
    rename_column :advertisements, :type, :ad_type
  end
end
