class AddAdvertisementIdToPendingNotification < ActiveRecord::Migration
  def change
    add_column :pending_notifications, :advertisement_id, :integer
  end
end
