class Api::CommentsApiController < ApplicationController

  def index
    @comments = Comment.all
    render json: {
      comments: @comments
    }
  end

  def show

    @comments = Comment.where(resource_id: params[:resource_id])
    current_user_comments = Comment.where("user_id = ? AND resource_id", "#{current_user.id}, #{params[:resource_id]}")
    comment_ratings_hash = {}
    current_user_comments.each do |comment|
      comment_ratings_hash[comment.id] = current_user.comment_ratings.
    end
  end
  
end