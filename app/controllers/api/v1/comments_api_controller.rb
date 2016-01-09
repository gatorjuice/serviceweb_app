class Api::V1::CommentsApiController < ApplicationController

  def index
    @comments = Comment.all
  end

  def show
    @comments = Comment.where(resource_id: params[:resource_id])
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
    @comment.save
  end

  def destroy
    resource = Resource.find_by(id: params[:resource])
    comment = Comment.find_by(id: params[:id])
    # comment.destroy
    redirect_to "/resources"
  end

end