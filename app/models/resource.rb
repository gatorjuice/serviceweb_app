class Resource < ActiveRecord::Base

  validates :name, presence: true
  validates :street, presence: true
  validates :phone, length: { is: 10 }
  validates :zip_code, length: { is: 5 }
  # validates :latitude, presence: true
  # validates :longitude, presence: true

  
  has_many :images
  has_many :comments
  belongs_to :user
  has_many :resource_ratings

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

  def lat_and_long
    "lat: #{latitude}, lng: #{longitude}"
  end

  def phone_with_dashes
    if phone != ""
      "(" + phone[0..2].to_s + ") " + phone[3..5].to_s + "-" + phone[6..9].to_s
    else
      nil
    end
  end

  def shorter_address
    address.slice(0..-16)
  end

  def score
    total = 0
    resource_ratings.each do |resource_rating|
      total += resource_rating.rating
    end
    total
  end

end

