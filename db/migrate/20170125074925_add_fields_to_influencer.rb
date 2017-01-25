class AddFieldsToInfluencer < ActiveRecord::Migration
  def change
    add_column :influencers, :gender, :integer
    add_column :influencers, :age, :integer
    add_column :influencers, :country, :text
  end
end
