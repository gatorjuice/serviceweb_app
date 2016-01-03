class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  before_filter :find_closest_resources

  def find_closest_resources
    @unverified_resources_count = Resource.where("status = ?", "unverified").length
    @food_resource = Resource.find_by(food: true)
    @health_resource = Resource.find_by(health: true)
    @shelter_resource = Resource.find_by(shelter: true)
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
