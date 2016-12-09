class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.integer :type
      t.text :url
      t.text :message
      t.string :title
      t.text :description
      t.text :caption
      t.integer :time_post
      t.integer :delay
      t.text :advertisement_link
      t.text :after_complete
      t.boolean :repeat
      t.text :end_date

      t.timestamps null: false
    end
  end
end
