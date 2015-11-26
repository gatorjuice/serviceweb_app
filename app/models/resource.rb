class Resource < ActiveRecord::Base
  has_many :images
  def resource_types
    resources = []
    if food == true
      resources << "food"
    end
    if health == true
      resources << "health"
    end
    if shelter == true
      resources << "shelter"
    end 
    resources   
  end

  def display_resources
    resource_types.join(", ").to_s
  end

end
