class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :resource_type
      t.string :name
      t.string :address
      t.string :phone
      t.string :description

      t.timestamps null: false
    end
  end
end
