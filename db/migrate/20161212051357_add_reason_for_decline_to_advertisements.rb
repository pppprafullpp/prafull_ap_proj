class AddReasonForDeclineToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :reason_for_decline, :text
  end
end
