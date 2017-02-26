class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :suggested_products, dependent: :destroy
  has_many :ratings, dependent: :destroy

  mount_uploader :profile_image, UserUploader

  validates :user_name, presence: true, length: {in: 3..15}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.validation.email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.validation.password}, allow: nil

  before_save {email.downcase!}

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end
end
