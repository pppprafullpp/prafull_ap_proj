class CreatePageInsights < ActiveRecord::Migration
  def change
    create_table :page_insights do |t|
      t.integer :page_fans
      t.integer :page_fans_online
      t.integer :page_fans_gender_age
      t.integer :page_views_total
      t.integer :page_consumptions_by_consumption_type
      t.text :facebook_page_id
      t.text :facebook_page_name

      t.timestamps null: false
    end
  end
end
