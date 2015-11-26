class AddColumnsToResources < ActiveRecord::Migration
  def change
    add_column :resources, :food, :boolean
    add_column :resources, :health, :boolean
    add_column :resources, :shelter, :boolean
  end
end
