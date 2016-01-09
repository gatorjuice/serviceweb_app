class Api::CommentsApiController < ApplicationController

  def index
    @comments = Comment.all
  end

  def show
    @comments = Comment.where(resource_id: params[:resource_id])
    current_user_comments = Comment.where("user_id = ? AND resource_id", "#{current_user.id}, #{params[:resource_id]}")
  end

  def create
    comment_body = params[:comment_input_body]
    resource_id = params[:comment_resource_id]
    user_id = params[:comment_user_id]
    Comment.create(
      user_id: user_id,
      resource_id: resource_id,
      body: comment_body
      )
    redirect_to "/resources/#{resource_id}"
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    comment.destroy
    redirect_to "/resources/#{params[:resource_id]}"
  end
end