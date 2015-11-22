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

end