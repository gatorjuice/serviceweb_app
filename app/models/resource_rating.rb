class ResourceRating < ActiveRecord::Base
  
  belongs_to :resource
  belongs_to :user

  def my_rating_phrase

    case rating
    when -1 
      "unfavorable"
    when 0
      "neutral"
    when 1
      "favorable"
    end

  end

end
