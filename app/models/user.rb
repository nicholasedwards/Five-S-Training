class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-\.]+@[\w\-\.]+\.[a-z]+\z/i	
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
end
