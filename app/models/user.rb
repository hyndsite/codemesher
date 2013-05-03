# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  attr_accessor :updating_password
  has_secure_password

  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :memberships
  has_many :groups, through: :memberships

  VALID_EMAIL_REGEX =/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50}
  validates :password, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
                            uniqueness: {case_sensitive: false}

  before_save { |user| user.email = user.email.downcase }
  before_save :create_remember_token


 def should_validate_password?
      updating_password || new_record?
 end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
