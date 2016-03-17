class DropImages < ActiveRecord::Migration
  def change
    drop_table :images
    drop_table :roles
    drop_table :user_roles
  end
end
