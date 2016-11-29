class CreateAppConfigurations < ActiveRecord::Migration
  def change
    create_table :app_configurations do |t|
      t.string :config_key
      t.string :config_value

      t.timestamps null: false
    end
  end
end
