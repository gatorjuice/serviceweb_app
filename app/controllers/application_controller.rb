class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  # before_filter :find_closest_resources
  skip_before_filter  :verify_authenticity_token

  def find_closest_resources(my_location)
    if current_user
      @unverified_resources_count = Resource.where("status = ? AND user_id <> ?", "unverified", "#{current_user.id}").count
      @unverified_resources = Resource.where("status = ? AND user_id <> ?", "unverified", "#{current_user.id}")
    else
      @unverified_resources_count = 0
    end
    @food_resources = Resource.where(food: true, status: "verified")
    @health_resources = Resource.where(health: true, status: "verified")
    @shelter_resources = Resource.where(shelter: true, status: "verified")
    @unverified_resources_count == 1 ? @count_english = "resource needs" : @count_english = "resources need"
    

    @food_resources.each do |resource|

      distance = Geocoder::Calculations.distance_between([resource.latitude, resource.longitude], [40.748433,-73.985655])

    end

  end


  private

  def auth_admin
    if user_signed_in? == false
      redirect_to "/resources"
    else
      unless current_user.roles.map {|role| true if role.name == "admin"}.include? true
        redirect_to "/resources"
      end
    end
  end


  protected

  def configure_devise_permitted_parameters
    registration_params = [:first_name, :last_name, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end

end
