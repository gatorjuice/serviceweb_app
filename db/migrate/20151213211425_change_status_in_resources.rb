class ChangeStatusInResources < ActiveRecord::Migration
  def change
    change_column :resources, :status, :string, default: "unverified"
  end
end
