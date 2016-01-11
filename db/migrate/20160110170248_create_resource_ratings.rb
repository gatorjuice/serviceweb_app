class CreateResourceRatings < ActiveRecord::Migration
  def change
    create_table :resource_ratings do |t|
      t.integer :resource_id
      t.integer :user_id
      t.integer :rating

      t.timestamps null: false
    end
  end
end
