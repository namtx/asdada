class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  # validates :product_id, presence: true
  # validates :order_id, presence: true
  # validates :quantity, presence: true,
  #   numericality: {greater_than_or_equal_to: Settings.validation.quantity}
  # validates :price, presence: true, numericality: true
  before_save :update_quantity_minus
  before_destroy :update_quantity_plus

  private

  def update_quantity_minus
    product = self.product
    if product.present?
      product.quantity -= self.quantity
      product.save
    end
    existing = OrderDetail.find_by order_id: self.order_id,
      product_id: self.product_id
    if existing.present?
      self.quantity += existing.quantity
          binding.pry
      OrderDetail.delete_all order_id: self.order_id, product_id: self.product_id
    end
  end

  def update_quantity_plus
    product = self.product
    if product.present?
      product.quantity += self.quantity
      product.save
    end
  end
end
