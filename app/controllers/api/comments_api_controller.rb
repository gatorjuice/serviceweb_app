class Api::CommentsApiController < ApplicationController

  def index
    @comments = Comment.all
    render json: {
      comments: @comments
    }
  end

  def show
    @comments = Comment.where(resource_id: params[:resource_id])
  end
  
end