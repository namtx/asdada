class SuggestedProduct < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ProductUploader

  validates :name, presence: true, length: {maximum: Settings.validation.name}
  validates :price, presence: true,
    numericality: {greater_than_or_equal_to: Settings.validation.price}
  validates :content, presence: true,
    length: {maximum: Settings.validation.content}
  validates :image, presence: true
end
