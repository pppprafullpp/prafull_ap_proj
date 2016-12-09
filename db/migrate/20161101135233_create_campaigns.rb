class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :category_id
      t.integer :advertiser_id
      t.text :title
      t.string :message
      t.string :description
      t.text :caption
      t.string :image
      t.string :url
      t.string :media_type
      t.string :platform_type
      t.datetime :post_start_time
      t.datetime :post_end_time
      t.integer :delay_time
      t.boolean :random_post_accounts,default: false
      t.boolean :delete_after_finished,default: false
      t.boolean :auto_pause_posts,default: false
      t.integer :time_pause
      t.integer :after_complete_post_count
      t.boolean :repeat_post,default: false
      t.string :repeat_frequency





      t.timestamps null: false
    end
  end
end
