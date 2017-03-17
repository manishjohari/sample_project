class UserSecret < ActiveRecord::Base
  validates :secret_code, presence: true, uniqueness: true
  before_validation :set_secret, on: :create

  def retrieve_secret_code
    loop do
      token = SecureRandom.hex(3)
      break token unless UserSecret.exists?(secret_code: token)
    end
  end

  def set_secret
    self.secret_code = retrieve_secret_code
  end
end
