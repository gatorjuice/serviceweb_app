class CommentRatingsController < ApplicationController

  def create
    comment_id = params[:comment_id]
    rating = params[:rating_value]
    @previous_comment_rating = CommentRating.where(comment_id: comment_id, user_id: 1)
    
    @previous_comment_rating.each do |rating|
      item_to_delete = CommentRating.find(rating.id)
      item_to_delete.destroy
    end

    CommentRating.create(
      comment_id: comment_id,
      rating: rating,
      user_id: 1 #this needs to be changed back to current_user.id
    )

  end

end
