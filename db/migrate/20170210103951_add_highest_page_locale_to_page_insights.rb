class AddHighestPageLocaleToPageInsights < ActiveRecord::Migration
  def change
    add_column :page_insights, :highest_page_locale_name, :text
    add_column :page_insights, :highest_page_locale_value, :text
  end
end
