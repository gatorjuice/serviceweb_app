class ResourcesController < ApplicationController

  require 'socket'

  before_action :auth_admin, except: [:index, :show, :share, :share_form]

  def home

  end


  def index
    @current_location = Geocoder.search(Socket.ip_address_list.detect(&:ipv4_private?).try(:ip_address))
    
    if params[:type]
      if params[:type] == "food"
        @resources = Resource.where("food = ? AND status = ?", "true", "verified").order(:name)
      elsif params[:type] == "health"
        @resources = Resource.where("health = ? AND status = ?", "true", "verified").order(:name)
      elsif params[:type] == "shelter"
        @resources = Resource.where("shelter = ? AND status = ?", "true", "verified").order(:name)
      end
    else
      @resources = Resource.where(status: "verified").order(:name)
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
      address: "#{params[:street]}, #{params[:city]}, #{params[:zip_code]}",
      city: params[:city],
      zip_code: params[:zip_code],
      phone: params[:phone],
      description: params[:description],
      street: params[:street]
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
      address: "#{params[:street]}, #{params[:city]}, #{params[:zip_code]}",
      city: params[:city],
      zip_code: params[:zip_code],
      phone: params[:phone],
      description: params[:description],
      street: params[:street]
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


