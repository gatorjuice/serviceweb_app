class Api::V1::ResourcesController < ApplicationController

  def index
    if params[:search]
      string = params[:search].downcase
      @resources = Resource.where("lower(name) LIKE ?", "%#{string}%")
    else
      @resources = Resource.all
    end
  end

  def delete
    @resource = Resource.find(params[:id])
    if @resource.destroy
    else
      render json: { errors: @resource.errors.full_messages }, status: 422
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
      food: params[:food],
      health: params[:health],
      shelter: params[:shelter],
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

  def find_closest_resources
    food_distance_data_array = []
    food_resources = Resource.where(food: true)
    food_resources.each do |resource|
      distance = Geocoder::Calculations.distance_between([resource.latitude, resource.longitude], [0, 0])
      food_distance_data_array << {
        resource: resource,
        distance: distance
       }
    end
    render json: food_distance_data_array
  end

end