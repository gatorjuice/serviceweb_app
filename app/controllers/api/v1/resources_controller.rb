class Api::V1::ResourcesController < ApplicationController

  def index
    if params[:search]
      string = params[:search].downcase
      @unverified_resources = Resource.where("lower(name) LIKE ? OR lower(description) LIKE ?", "%#{string}%", "%#{string}%")
    else
      @unverified_resources = []
      Resource.all.each do |resource|
        @unverified_resources << resource if resource.resource_ratings.exists?(user_id: current_user.id) == false
      end
    end
    p @unverified_resources
    @unverified_resources

  end

  def delete
    if current_user.admin 
      @resource = Resource.find(params[:id])
      if @resource.destroy
        redirect_to "/home"
      else
        render json: { errors: @resource.errors.full_messages }, status: 422
      end
    else
      flash[:warning] = "you are not authorized to delete resources."
      redirect_to "/home"
    end
  end

  def update
    @resource = Resource.find_by(id: params[:id])
    if params[:status] == "verified"
      status = "verified"
    else
      status = @resource.status
    end
    @resource.update(
      food: params[:food] || @resource.food,
      health: params[:health] || @resource.health,
      shelter: params[:shelter] || @resource.shelter,
      name: params[:name] || @resource.name,
      address: "#{params[:street] || @resource.street}, #{params[:city] || @resource.city}, #{params[:zip_code] || @resource.zip_code}",
      city: params[:city] || @resource.city,
      zip_code: params[:zip_code] || @resource.zip_code,
      phone: params[:phone] || @resource.phone,
      description: params[:description] || @resource.description,
      street: params[:street] || @resource.street,
      status: status
      )
    flash[:info] = "Resource Successfully Updated"
  end
  
  def find_closest_food_resource
    input_lat = params[:lat]
    input_lng = params[:lng]
    food_distance_data_array = []
    food_resources = Resource.where(food: true)

    food_resources.each do |resource|
      if resource.score > 0 
        distance = Geocoder::Calculations.distance_between([resource.latitude, resource.longitude], [input_lat, input_lng])
        
        food_distance_data_array << {
          distance: distance,
          resource: resource
        }
      end
    end
    sorted = food_distance_data_array.sort_by! { |k| k[:distance] }
    render json: sorted.first
  end

  def find_closest_health_resource
    input_lat = params[:lat]
    input_lng = params[:lng]
    health_distance_data_array = []
    health_resources = Resource.where(health: true)

    health_resources.each do |resource|
      if resource.score > 0 
        distance = Geocoder::Calculations.distance_between([resource.latitude, resource.longitude], [input_lat, input_lng])
        
        health_distance_data_array << {
          distance: distance,
          resource: resource
        }
      end
    end
    sorted = health_distance_data_array.sort_by! { |k| k[:distance] }
    render json: sorted.first
  end

  def find_closest_shelter_resource
    input_lat = params[:lat]
    input_lng = params[:lng]
    shelter_distance_data_array = []
    shelter_resources = Resource.where(shelter: true)

    shelter_resources.each do |resource|
      if resource.score > 0 
        distance = Geocoder::Calculations.distance_between([resource.latitude, resource.longitude], [input_lat, input_lng])
        
        shelter_distance_data_array << {
          distance: distance,
          resource: resource
        }
      end
    end
    sorted = shelter_distance_data_array.sort_by! { |k| k[:distance] }
    render json: sorted.first
  end

  def leaderboard
    leaderboard = []
    resources = Resource.all
    resources.each do |resource|
      if resource.score > 0
        leaderboard << {
          resource: resource,
          services: resource.display_resources.capitalize,
          score: resource.score
        }
      end
    end

    leaderboard.sort_by! {|resource| resource[:score] }
    p leaderboard.first
    render json: leaderboard
  end

end