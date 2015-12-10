class RenameFullStreetAddressInResources < ActiveRecord::Migration
  def change
    rename_column(:resources, :full_street_address, :street)
  end
end
