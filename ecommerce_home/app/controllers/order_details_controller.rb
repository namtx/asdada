class OrderDetailsController < ApplicationController
  def create
    @order = current_order
    @order_detail = @order.order_details.new(order_detail_params)
    @order.user = current_user
    @order.order_status = OrderStatus.first
    @order.save!
    session[:order_id] = @order.id
  end

  def update
    @order = current_order
    @order_detail = @order.order_details.find_by id: params[:id]
    @order_detail.update_attribute order_detail_params
    @order_details = @order.order_details
  end

  def destroy
    @order = current_order
    @order_detail = @order.order_details.find_by id: params[:id]
    @order_detail.destroy
    @order_details = @order.order_details
  end

  private
  def order_detail_params
    params.require(:order_detail).permit :quantity, :product_id
  end
end
