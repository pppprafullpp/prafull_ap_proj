class CreateSocialAccounts < ActiveRecord::Migration
  def change
    create_table :social_accounts do |t|
      t.integer :influencer_id
      t.integer :platform_type
      t.text :platform_type_id
      t.text :platform_link

      t.timestamps null: false
    end
  end
end
