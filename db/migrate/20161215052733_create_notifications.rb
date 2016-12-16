class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :activity_type
      t.text :activity
      t.boolean :viewed

      t.timestamps null: false
    end
  end
end
