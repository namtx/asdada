class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :quantity, presence: true,
    numericality: {greater_than_or_equal_to: Settings.validation.quantity}
  validates :price, presence: true, numericality: true

  scope :group_by_product_this_day, -> {
    where("")
    .left_outer_joins(:product)
    .group("products.id")
    .sum(:quantity)}

  scope :scope_name, -> { where(field: true)   }

  def self.product_order_chart_data
    self.group_by_product.transform_keys { |product_id| Product.find_by(id: product_id).name }
  end
end
