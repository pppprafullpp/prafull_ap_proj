class AddSocialDataColumnToInfluncers < ActiveRecord::Migration
  def change
    add_column :influencers, :facebook_page_count, :integer
    add_column :influencers, :instagram_page_count, :integer
  end
end
