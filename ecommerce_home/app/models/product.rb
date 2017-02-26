class Product < ApplicationRecord
  belongs_to :sub_category
  belongs_to :classification
  has_many :order_details, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy

  mount_uploader :image, ProductUploader
  validates :name, presence: true, length: {maximum: Settings.validation.name}
  validates :description, presence: true,
    length: {maximum: Settings.validation.content}
  validates :price, presence: true,
    numericality: {greater_than_or_equal_to: Settings.validation.price}
  validates :quantity, presence: true, numericality: {only_integer: true}
  validates :sub_category_id, presence: true
  validates :classification_id, presence: true
end
