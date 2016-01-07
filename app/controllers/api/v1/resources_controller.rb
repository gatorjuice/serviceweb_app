class Api::V1::ResourcesController < ApplicationController

  def unverified
    
  end
  def index
    @resources = Resource.all
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

end