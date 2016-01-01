class Comment < ActiveRecord::Base
  belongs_to :resource
  belongs_to :user
  has_many :comment_ratings

  def total_rating
    total = 0
    comment_ratings.each do |comment_rating|
      total += comment_rating.rating
    end
    total
  end
end
