class Resource < ActiveRecord::Base
  has_many :images
  belongs_to :user
  def resource_types
    resources = []
    if food
      resources << "food"
    end
    if health
      resources << "health"
    end
    if shelter
      resources << "shelter"
    end 
    resources   
  end

  def display_resources
    resource_types.join(", ").to_s
  end

end
