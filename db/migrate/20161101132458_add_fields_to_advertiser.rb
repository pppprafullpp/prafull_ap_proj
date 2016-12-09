class AddFieldsToAdvertiser < ActiveRecord::Migration
  def change
  	add_column :advertisers, :name, :string
    add_column :advertisers, :telephone_no,:string
    add_column :advertisers, :address, :string
    add_column :advertisers, :city, :string
    add_column :advertisers, :state, :string
    add_column :advertisers, :country, :string
    add_column :advertisers, :zip, :string
    add_column :advertisers, :username, :string
    add_column :advertisers, :providerid, :string
    add_column :advertisers, :uid, :string
  end
end
