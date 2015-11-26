class RemoveResourceTypeFromResources < ActiveRecord::Migration
  def change
    remove_column :resources, :resource_type, :string
  end
end
