class AddCategoryToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :category, :integer
  end
end
