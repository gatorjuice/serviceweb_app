class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :comments
  has_many :comment_ratings
  has_many :resource_ratings
  has_many :resources

  def full_name
    "#{first_name} #{last_name} (#{user_score})"
  end

  def user_score
    score = 0
    resources.each do |resource|
      resource.resource_ratings.each do |resource_rating|
        score = score + resource_rating.rating
      end
    end
    score
  end

  def privileges
    if user_score > 0
      "full access"
    elsif user_score == 0
      "probationary"
    else
      "restricted access"
    end
  end

  def score_color
    if user_score < 0
      "danger"
    elsif user_score == 0
      "warning"
    else
      "success"
    end
  end

end
