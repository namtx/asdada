class Order < ApplicationRecord
  belongs_to :user
  belongs_to :order_status
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  accepts_nested_attributes_for :order_details

  validates :address, presence: true,
    length: {maximum: Settings.validation.address}
  validates :full_name, presence: true,
    length: {maximum: Settings.validation.full_name}
  validates :phone, presence: true, length: {maximum: Settings.validation.phone}
end
