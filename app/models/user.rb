class User < ActiveRecord::Base
  before_create :create_activation_digest  
  VALID_EMAIL_REGEX = /\A[\w+\-\.]+@[\w\-\.]+\.[a-z]+\z/i	
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, allow_nil: true
  has_secure_password
  has_many :lesson_completions, dependent: :destroy
  has_many :completed_lessons, through: :lesson_completions, source: :lesson

  def activate?(activation_token)
    BCrypt::Password.new(activation_digest).is_password?(activation_token)
  end

  private

    def User.new_token
      SecureRandom.urlsafe_base64
    end

    def User.digest(string)
      BCrypt::Password.create(string)
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
