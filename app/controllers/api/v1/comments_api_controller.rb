class Api::V1::CommentsApiController < ApplicationController

  def index
    comments = Comment.all
    @comments = comments.sort_by { |comment| comment.total_rating }.reverse
  end

  def show
    @comments = Comment.where(resource_id: params[:resource_id])
    @comments_count = @comments.length
    current_user_comments = Comment.where("user_id = ? AND resource_id", "#{current_user.id}, #{params[:resource_id]}")
  end

  def create
    comment_body = params[:inputCommentBody]
    resource_id = params[:inputResourceId]
    user_id = params[:inputUserId]
    @comment = Comment.new(
      user_id: user_id,
      resource_id: resource_id,
      body: comment_body
      )
    if @comment.save
    else
      render json: { error: "your cannot submit a blank comment."}
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id])
    comment.destroy
    render nothing: true
  end

end