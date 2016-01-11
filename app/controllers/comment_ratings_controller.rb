class CommentRatingsController < ApplicationController

  def create
    comment_id = params[:commentId]
    rating = params[:ratingValue]
    @previous_comment_rating = CommentRating.where(comment_id: comment_id, user_id: current_user.id)
    
    @previous_comment_rating.each do |rating|
      item_to_delete = CommentRating.find(rating.id)
      item_to_delete.destroy
    end

    CommentRating.create(
      comment_id: comment_id,
      rating: rating,
      user_id: current_user.id #this needs to be changed back to current_user.id
    )
    render json: { value: "hjelllo" }
  end

end
