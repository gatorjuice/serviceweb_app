class ResourcesController < ApplicationController

  def home

  end


  def index
    if params[:type]
      if params[:type] == "food"
        @resources = Resource.where("food = ?", "true")
      elsif params[:type] == "health"
        @resources = Resource.where("health = ?", "true")
      elsif params[:type] == "shelter"
        @resources = Resource.where("shelter = ?", "true")
      end
    else
      @resources = Resource.all
    end
  end

  def new   
  end

  def create

    Resource.create(
      food: params[:food],
      health: params[:health],
      shelter: params[:shelter],
      name: params[:name],
      address: params[:address],
      city: params[:city],
      zip_code: params[:zip_code],
      phone: params[:phone],
      description: params[:description]
      )
    flash[:success] = "Resource Successfully Created"
    redirect_to '/resources'
  end

  def show
    @resource = Resource.find_by(id: params[:id])
  end

  def edit
    @resource = Resource.find_by(id: params[:id])
  end

  def update
    @resource = Resource.find_by(id: params[:id])
    @resource.update(
      food: params[:food],
      health: params[:health],
      shelter: params[:shelter],
      name: params[:name],
      address: params[:address],
      city: params[:city],
      zip_code: params[:zip_code],
      phone: params[:phone],
      description: params[:description]
      )
    flash[:info] = "Resource Successfully Updated"
    redirect_to '/resources'
  end

  def destroy
    @resource = Resource.find_by(id: params[:id])
    @resource.destroy
    flash[:danger] = "Resource Successfully Deleted"
    redirect_to "/resources"
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

    account_sid = open('lib/assets/.twilio_api_id').read()
    auth_token = open('lib/assets/.twilio_api_token').read()

    @client = Twilio::REST::Client.new account_sid, auth_token 
    @client.account.messages.create({
      :from => '+17089548869',
      :to => send_to_number,
      :body => "Please call #{name}:\n#{phone}\nThey are located at:\n#{address}\n#{description}"    
      })
  end

end