class CommentRatingsController < ApplicationController

  def create
    comment_id = params[:commentId]
    rating = params[:ratingValue]
    @previous_comment_rating = CommentRating.where(comment_id: comment_id, user_id: current_user.id)
    
    if rating == -1
      vote_type = :down_vote
    else
      vote_type = :up_vote
    end

    if @previous_comment_rating.length == 0
      render json: {
        vote: :vote_type,
        exists: false
      }
    else
      render json: {
        vote: :vote_type,
        exists: true
      }
    end

    @previous_comment_rating.each do |rating|
      item_to_delete = CommentRating.find(rating.id)
      item_to_delete.destroy
    end

    @new_comment_rating = CommentRating.create(
      comment_id: comment_id,
      rating: rating,
      user_id: current_user.id #this needs to be changed back to current_user.id
    )
  end

end
