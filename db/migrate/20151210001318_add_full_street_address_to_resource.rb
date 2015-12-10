class AddFullStreetAddressToResource < ActiveRecord::Migration
  def change
    add_column :resources, :full_street_address, :string
  end
end
