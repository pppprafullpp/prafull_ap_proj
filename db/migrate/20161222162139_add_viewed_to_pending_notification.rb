class AddViewedToPendingNotification < ActiveRecord::Migration
  def change
    add_column :pending_notifications, :viewed, :boolean
  end
end
