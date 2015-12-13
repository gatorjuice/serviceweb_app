class Resource < ActiveRecord::Base
  has_many :images
  belongs_to :user

  geocoded_by :address   # can also be an IP address
  after_validation :geocode, if: ->(resource){ resource.address.present? and resource.address_changed? }

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  acts_as_mappable
  
  def resource_types
    resources = []
    resources << "food" if food
    resources << "health" if health
    resources << "shelter" if shelter
    resources   
  end

  def display_resources
    resource_types.join(", ").to_s
  end

  def verify
    update_attribute(:status, "verified")
  end


end
