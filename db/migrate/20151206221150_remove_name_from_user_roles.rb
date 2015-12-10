class RemoveNameFromUserRoles < ActiveRecord::Migration
  def change
    remove_column :user_roles, :name, :string
  end
end
