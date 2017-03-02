class CartsController < ApplicationController
  def index
    @products = current_order.products
    @order_details = current_order.order_details
  end
end
