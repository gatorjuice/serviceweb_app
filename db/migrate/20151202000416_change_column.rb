class ChangeColumn < ActiveRecord::Migration
  def change
rename_column :resources, :street, :address
    
  end
end