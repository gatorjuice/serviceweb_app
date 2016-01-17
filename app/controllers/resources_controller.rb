class ResourcesController < ApplicationController

  require 'socket'

  def home
    @resources = Resource.all
    @all_verified_resources = []
    @resources.each do |resource|
      @all_verified_resources << resource if resource.score > 0
    end
  end

  def index
    # @current_location = Geocoder.search(Socket.ip_address_list.detect(&:ipv4_private?).try(:ip_address))
    # @location = Geokit::Geocoders::IpGeocoder.geocode(@current_location[0].data["ip"].to_s)
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
    if user_signed_in? 
      @resource = Resource.new
    else
      redirect_to '/resources' 
    end 
  end

  def create
    @resource = Resource.new(
      food: params[:food],
      health: params[:health],
      shelter: params[:shelter],
      name: params[:name],
      address: "#{params[:street]}, #{params[:city]}, #{params[:zip_code]}",
      city: params[:city],
      zip_code: /[^\D]\d*/.match(params[:zip_code]),
      phone: params[:phone],
      description: params[:description],
      street: params[:street],
      user_id: current_user.id
      )
    if @resource.save
      flash[:success] = "Resource Successfully Created"
      redirect_to "/resources"
    else
      render :new
    end
  end

  def show
    @resource = Resource.find_by(id: params[:id])
    comments = Comment.where(resource_id: params[:resource_id])
    @comments_count = comments.length
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
    if current_user && current_user.admin
      @resource = Resource.find_by(id: params[:id])
      @resource.destroy
      flash[:danger] = "Resource Successfully Deleted"
      if params[:from_unverified_list]
        redirect_to "/resources?status=unverified"
      else
        redirect_to "/resources"
      end
    else
      flash[:warning] = "you are not authorized to delete resources"
      redirect_to "/home"
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

    body = "Call #{name}\nPhone\n#{phone}\nAddress\n#{address}"#\n\nCapstone attendees:\nemail me at gatorjuice@gmail.com learn more."
    
    account_sid = ENV['TWILIO_API_ID']
    auth_token = ENV['TWILIO_API_TOKEN']

    begin
      @client = Twilio::REST::Client.new account_sid, auth_token 
      @client.account.messages.create(
        from: '+17089548869',
        to: send_to_number,
        body: body    
        )
    rescue
      flash[:warning] = "something went wrong please try again."
      redirect_to "/home"
    else
      flash[:success] = "you have successfully shared the resource. Thank you."
      redirect_to "/home"
    end
  end


  def demo
    ResourceRating.all.each {|x| x.destroy}
    redirect_to "/home"
  end

end








