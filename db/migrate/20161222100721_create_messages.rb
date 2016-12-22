class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message_from_type
      t.string :message_to_type
      t.integer :message_from_id
      t.integer :message_to_id
      t.text :message

      t.timestamps null: false
    end
  end
end
