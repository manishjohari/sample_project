class UserSecret < ActiveRecord::Base
  validates :secret_code, presence: true, uniqueness: true
end
