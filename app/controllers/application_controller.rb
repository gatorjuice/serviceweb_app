class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :find_closest_resources

  def find_closest_resources
    @food_resource = Resource.find_by(food: true)
    @health_resource = Resource.find_by(health: true)
    @shelter_resource = Resource.find_by(shelter: true)
  end
end
