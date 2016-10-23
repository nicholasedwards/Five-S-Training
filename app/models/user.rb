class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-\.]+@[\w\-\.]+\.[a-z]+\z/i	
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, allow_nil: true
  has_secure_password
  has_many :lesson_completions
  has_many :completed_lessons, through: :lesson_completions, source: :lesson
end
