class AccountsController < ApplicationController

  def show
    if current_user
      @current_user = current_user
      @current_user_resources = Resource.where(user_id: current_user.id)
      @current_user_resource_ratings = ResourceRating.where(user_id: current_user.id)
      p @current_user_resource_ratings.first
    else
      redirect_to "/home"
    end
  end

  def set_position
    @@user_lat = params[:latitude]
    @@user_lng = params[:longitude]

    session[:user_lat] = @@user_lat
    session[:user_lng] = @@user_lng
    
    render json: {
      currentLat: @@user_lat,
      currentLng: @@user_lng
    }
  end

end
