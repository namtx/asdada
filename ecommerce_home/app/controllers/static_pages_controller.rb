class StaticPagesController < ApplicationController
  def home
    @hot_trends = Product.top_order_products.take(12)
    @new_products = Product.top_new_products
    @order_detail = current_order.order_details.new
  end
end
