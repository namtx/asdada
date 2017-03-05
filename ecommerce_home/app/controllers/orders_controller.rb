class OrdersController < ApplicationController

  def create
    @order = current_user.orders.build order_params
    ActiveRecord::Base.transaction do
      if @order.save!
        add_order_item
        destroy_cart
        @order.send_confirmation_email current_user
        flash[:info] = "Order confirmation email has sent. Please check email to confirm your order"
        redirect_to carts_path
      else
        flash_slq_error @order
      end
    end
  end

  private

  def order_params
    params.require(:order).permit :order_status_id, :address
  end

  def destroy_cart
    current_cart.destroy
  end

  def flash_slq_error object
    flash[:danger] = object.errors.full_messages
    redirect_to root_url
  end

  def add_order_item
    current_cart.products.each do |product|
      order_detail = @order.order_details.build product_id: product.id,
        quantity: (current_cart.quantity product), price: product.price
      unless order_detail.save!
        flash_slq_error order_item
      end
    end
  end
end
