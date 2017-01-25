class CreateInfluencerFinancialInfos < ActiveRecord::Migration
  def change
    create_table :influencer_financial_infos do |t|
      t.integer :influencer_id
      t.text :bank_name
      t.text :bank_branch
      t.text :ifsc_code
      t.text :ac_type
      t.text :ac_number

      t.timestamps null: false
    end
  end
end
