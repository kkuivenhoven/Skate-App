# Sources:
# https://www.railstutorial.org/book, Hartl Michael, 2014
# Note: this User model comes from https://www.railstutorial.org/book/modeling_users
# http://www.jorgecoca.com/buils-search-form-ruby-rails/

class User < ActiveRecord::Base
	has_friendship
  has_many :responses
  has_many :skate_spots
  has_many :ratings, :through => :skate_spots
	has_many :microposts, dependent: :destroy # https://www.railstutorial.org/book, Hartl Michael, 2014 
	has_many :skate_comments, :through => :skate_spots, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed # https://www.railstutorial.org/book, Hartl Michael, 2014
  has_many :followers, through: :passive_relationships, source: :follower # https://www.railstutorial.org/book, Hartl Michael, 2014
	
	serialize :blocked_by, Hash
	serialize :user_blocked, Hash

  attr_accessor :remember_token, :activation_token, :reset_token # https://www.railstutorial.org/book, Hartl Michael, 2014
  before_save   :downcase_email # https://www.railstutorial.org/book, Hartl Michael, 2014
  before_create :create_activation_digest # https://www.railstutorial.org/book, Hartl Michael, 2014

  validates :name, presence: true, length: { maximum: 50 } # https://www.railstutorial.org/book, Hartl Michael, 2014
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } # https://www.railstutorial.org/book, Hartl Michael, 2014

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  class << self # https://www.railstutorial.org/book, Hartl Michael, 2014
    # Returns the hash digest of the given string.
    def digest(string)
    #def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    #def User.new_token
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Remembers a user in the database for use in persistent sessions.
  # https://www.railstutorial.org/book, Hartl Michael, 2014
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
	# https://www.railstutorial.org/book, Hartl Michael, 2014
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  # https://www.railstutorial.org/book, Hartl Michael, 2014
  def forget
    update_attribute(:remember_digest, nil)
  end

  def self.search(search)
    where("name LIKE ?", "%#{search}%") 
  end

  # Logs out the current user.
	# https://www.railstutorial.org/book, Hartl Michael, 2014
  def log_out
    current_user && forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Activates an account.
	# https://www.railstutorial.org/book, Hartl Michael, 2014
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Sends activation email.
  # https://www.railstutorial.org/book, Hartl Michael, 2014
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  # https://www.railstutorial.org/book, Hartl Michael, 2014
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token),
                   reset_sent_at: Time.zone.now)
  end

  # Sends password reset email.
  # https://www.railstutorial.org/book, Hartl Michael, 2014
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  # https://www.railstutorial.org/book, Hartl Michael, 2014
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def rating_feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Rating.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # Follows a user.
  # https://www.railstutorial.org/book, Hartl Michael, 2014
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  # https://www.railstutorial.org/book, Hartl Michael, 2014
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Blocks a user.
  def block(other_user)
    following.delete(other_user)
		self.update_columns(blocked_users: other_user.id)
  end

  # Returns true if the current user is following the other user.
  # https://www.railstutorial.org/book, Hartl Michael, 2014
  def following?(other_user)
    following.include?(other_user)
  end

	def user_has_blocked(other_user)
		blocked_id = self.user_blocked[other_user.id]
		if blocked_id.nil?
				# user has not blocked by other_user
				return false
		elsif blocked_id == 0
				# user has not blocked by other_user
				return false
		else
				# user has blocked by other_user
				return true
		end
	end


	def user_blocked_by?(other_user)
		if self.blocked_by.nil?
				return false
		else
						blocked_id = self.blocked_by[other_user.id]
						if blocked_id.nil?
								# user is not blocked by other_user
								return false
						else
								# user is blocked by other_user
								return true
						end
	  end
	end



  private

    # Converts email to all lower-case.
    # https://www.railstutorial.org/book, Hartl Michael, 2014
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    # https://www.railstutorial.org/book, Hartl Michael, 2014
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end


end
