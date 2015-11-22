class AddCityToResources < ActiveRecord::Migration
  def change
    add_column :resources, :city, :string
    add_column :resources, :state, :string
    add_column :resources, :zip_code, :string
  end
end
