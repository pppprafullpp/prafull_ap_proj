class AddGroupNameToGroupMapping < ActiveRecord::Migration
  def change
    add_column :group_mappings, :group_name, :text
  end
end
