class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.string :name
      t.integer :user_id
      t.integer :role_id

      t.timestamps null: false
    end
  end
end
