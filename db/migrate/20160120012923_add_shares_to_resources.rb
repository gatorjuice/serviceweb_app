class AddSharesToResources < ActiveRecord::Migration
  def change
    add_column :resources, :shares, :integer
  end
end
