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
    @resources = []
    resources = Resource.where("#{params[:type]}": true)
    resources.each do |resource|
      @resources << resource if resource.score > 0
    end
    @resources.sort_by! { |resource| resource.score }
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
      ResourceRating.create(
        resource_id: @resource.id,
        user_id: @resource.user_id,
        rating: 1
      )
      flash[:success] = "Resource Successfully Created"
      redirect_to "/home"
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
      redirect_to "/home"
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
    opt_message = params[:opt_message]

    body = "#{opt_message}\n\nCall #{name}\nPhone\n#{phone}\nAddress\n#{address}\n\nCapstone attendees:\nemail me at gatorjuice@gmail.com to learn more."
    
    account_sid = ENV['TWILIO_API_ID']
    auth_token = ENV['TWILIO_API_TOKEN']

    begin
    rescue
      flash[:warning] = "something went wrong please try again."
      redirect_to "/home"
    else
      @client = Twilio::REST::Client.new account_sid, auth_token 
      @client.account.messages.create(
        from: '+17089548869',
        to: send_to_number,
        body: body    
        )
      resource = Resource.find_by(name: name)
      shares = resource.shares
      shares = shares + 1
      resource.update(shares: shares)
      flash[:success] = "you have successfully shared the resource. Thank you."
      redirect_to "/home"
    end
  end


  def demo
    ResourceRating.all.each {|x| x.destroy}
    redirect_to "/home"
  end

end








