class ResourcesController < ApplicationController

  require 'socket'

  # before_action :auth_admin, except: [:index, :show, :share, :share_form]

  def home
    @resources = Resource.where(status: "verified") 
 
  end


  def index
    @current_location = Geocoder.search(Socket.ip_address_list.detect(&:ipv4_private?).try(:ip_address))
    @location = Geokit::Geocoders::IpGeocoder.geocode(@current_location[0].data["ip"].to_s)
    if params[:type] == "food"
      @resources = Resource.where("food = ? AND status = ?", "true", "verified").order(:name)
    elsif params[:type] == "health"
      @resources = Resource.where("health = ? AND status = ?", "true", "verified").order(:name)
    elsif params[:type] == "shelter"
      @resources = Resource.where("shelter = ? AND status = ?", "true", "verified").order(:name)
    elsif params[:status] == "unverified"
      if @unverified_resources_count == 0
        flash[:info] = "completed resource verification"
        redirect_to "/resources"
      else
        @resources = Resource.where(status: "unverified").order(:name)
      end
    else
      @resources = Resource.where(status: "verified").order(:name)
    end
  end

  def new 
    unless user_signed_in? 
      redirect_to '/resources'  
    end
  end

  def create
    Resource.create(
      food: params[:food],
      health: params[:health],
      shelter: params[:shelter],
      name: params[:name],
      address: "#{params[:street]}, #{params[:city]}, #{params[:zip_code]}",
      city: params[:city],
      zip_code: params[:zip_code],
      phone: params[:phone],
      description: params[:description],
      street: params[:street],
      user_id: current_user.id || nil
      )
    flash[:success] = "Resource Successfully Created"
    redirect_to "/resources"
  end

  def show
    @resource = Resource.find_by(id: params[:id])
    if current_user
      @my_rating = ResourceRating.find_by(resource_id: @resource.id, user_id: current_user.id)
    end
  end

  def edit
    @resource = Resource.find_by(id: params[:id])
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
    redirect_to "/resources/#{@resource.id}"
  end

  def destroy
    @resource = Resource.find_by(id: params[:id])
    @resource.destroy
    flash[:danger] = "Resource Successfully Deleted"
    if params[:from_unverified_list]
      redirect_to "/resources?status=unverified"
    else
      redirect_to "/resources"
    end
  end

  def share_form
    @resource = Resource.find_by(id: params[:id])
  end

  def share
    send_to_number = params[:send_to_number]
    name = params[:name]
    phone = params[:phone]
    address = params[:address]
    description = params[:description]

    body = "Call #{name}\nPhone\n#{phone}\nAddress\n#{address}\n\nCapstone attendees:\nemail me at gatorjuice@gmail.com learn more."
    
    p body.length

    account_sid = open('lib/assets/.twilio_api_id').read()
    auth_token = open('lib/assets/.twilio_api_token').read()

    @client = Twilio::REST::Client.new account_sid, auth_token 
    @client.account.messages.create({
      :from => '+17089548869',
      :to => send_to_number,
      :body => body    
      })
  end

  def recent_comments
    Comment.all
  end

end


