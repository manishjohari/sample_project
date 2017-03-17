class User < ActiveRecord::Base

  # ref code link
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address

  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  # validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validate :validate_username

  has_one :user_secret

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

 def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end  

  private

  before_save do 
    email = self.email.downcase if self.email
    username = self.username.downcase if self.username
  end
end
