class AddCategoryToInfluencerGroup < ActiveRecord::Migration
  def change
    add_column :influencer_groups, :category_id, :integer
  end
end
