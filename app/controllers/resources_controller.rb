class ResourcesController < ApplicationController

  def index
    @resources = Resource.all
  end

  def new   
  end

  def create
    Resource.create(
      resource_type: params[:resource_type],
      name: params[:name],
      address: params[:address],
      city: params[:city],
      zip_code: params[:zip_code],
      phone_number: params[:phone_number],
      description: params[:description]
      )
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
      resource_type: params[:resource_type],
      name: params[:name],
      address: params[:address],
      city: params[:city],
      zip_code: params[:zip_code],
      phone_number: params[:phone_number],
      description: params[:description]
      )
    redirect_to '/resources'
  end

  def destroy
    @resource = Resource.find_by(id: params[:id])
    @resource.destroy
    redirect_to "/resources"
  end

  def share_form
    @resource = Resource.find_by(id: params[:id])
  end

  def share
    send_to_number = params[:send_to_number]
    name = params[:name]
    phone_number = params[:phone_number]
    address = params[:address]
    description = params[:description]

    account_sid = open('lib/assets/.api_id').read()
    auth_token = open('lib/assets/.api_token').read()

    @client = Twilio::REST::Client.new account_sid, auth_token 
    @client.account.messages.create({
      :from => '+17089548869',
      :to => send_to_number,
      :body => "Please call #{name}:\n#{phone_number}\nThey are located at:\n#{address}\n#{description}"    
      })
  end

end