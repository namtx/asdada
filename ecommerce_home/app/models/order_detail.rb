class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :quantity, presence: true,
    numericality: {greater_than_or_equal_to: Settings.validation.quantity}
  validates :price, presence: true, numericality: true
end
