class CommentsController < ApplicationController

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
    resource = Resource.find_by(id: params[:resource])
    comment = Comment.find_by(id: params[:id])
    # comment.destroy
    redirect_to "/resources"
  end

end