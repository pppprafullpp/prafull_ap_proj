class AddPublishingPriceToInfluencers < ActiveRecord::Migration
  def change
    add_column :influencers, :publishing_price, :text
  end
end
