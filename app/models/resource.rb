class Resource < ActiveRecord::Base
  has_many :images
  belongs_to :user
  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address
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

  def full_street_address
    "#{address}, #{state}  #{zip_code}"
  end
end
