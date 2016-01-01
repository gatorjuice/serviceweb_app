class CreateCommentRatings < ActiveRecord::Migration
  def change
    create_table :comment_ratings do |t|
      t.integer :user_id
      t.integer :comment_id
      t.integer :rating

      t.timestamps null: false
    end
  end
end
