class Api::V1::ResourceRatingsController < ApplicationController

  def create
    resource_id = params[:id]
    user_id = current_user.id
    rating = params[:rating]

    resource_rating = ResourceRating.new(
      user_id: user_id,
      resource_id: resource_id,
      rating: rating
    )

    previous_resource_ratings = ResourceRating.where(
      user_id: user_id,
      resource_id: resource_id
    )

    previous_resource_ratings.each do |rating|
      rating.destroy
    end

    resource_rating.save

    render json: {
      user_id: resource_rating.user_id,
      resource_id: resource_rating.resource_id,
      rating: resource_rating.rating
    }
  end

end
