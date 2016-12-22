class CreatePendingNotifications < ActiveRecord::Migration
  def change
    create_table :pending_notifications do |t|
      t.integer :notification_type
      t.integer :influencer_id
      t.integer :advertiser_id
      t.text :notification_text

      t.timestamps null: false
    end
  end
end
