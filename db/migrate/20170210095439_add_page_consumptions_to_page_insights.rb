class AddPageConsumptionsToPageInsights < ActiveRecord::Migration
  def change
    add_column :page_insights, :page_consumptions, :integer
  end
end
