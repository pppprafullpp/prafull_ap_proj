class ChangeColumnAdTypeInAdvertisement < ActiveRecord::Migration
  def change
    change_column :advertisements, :ad_type, :string
  end
end
