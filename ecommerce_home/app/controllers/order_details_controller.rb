class OrderDetailsController < ApplicationController
  before_action :load_current_order, only: [:create, :update, :destroy]
  before_action :load_order_detail, only: [:update, :destroy]
  def create
    @order_detail = @order.order_details.new order_detail_params
    if @order_detail.product.quantity < params[:order_detail][:quantity].to_i
      flash.now[:danger] = "Product #{@order_detail.product.name} is out of stock now."
      respond_to do |format|
        format.html
        format.js
      end
    else
      @order.user = current_user
      @order.order_status = OrderStatus.first
      @order.save!
      session[:order_id] = @order.id
    end
  end

  def update
    @order_detail.update_attributes order_detail_params
    @order_details = @order.order_details
  end

  def destroy
    @order_detail.destroy
    @order_details = @order.order_details
  end

  private
  def order_detail_params
    params.require(:order_detail).permit :quantity, :product_id
  end

  def load_current_order
    @order = current_order
  end

  def load_order_detail
    @order_detail = load_current_order.order_details.find_by id: params[:id]
  end
end
