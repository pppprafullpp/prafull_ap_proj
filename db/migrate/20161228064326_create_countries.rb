class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.text :country_name

      t.timestamps null: false
    end
  end
end
