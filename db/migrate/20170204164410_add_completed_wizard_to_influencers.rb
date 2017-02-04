class AddCompletedWizardToInfluencers < ActiveRecord::Migration
  def change
    add_column :influencers, :completed_wizard, :boolean
  end
end
