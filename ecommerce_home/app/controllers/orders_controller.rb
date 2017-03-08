class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :load_order, only: :show
  def create
    @order = current_user.orders.build order_params
    @order.order_status_id = Settings.order.status_default
    ActiveRecord::Base.transaction do
      if @order.save
        add_order_item
        current_cart.checkout
        @order.send_confirmation_email current_user
        flash[:info] = t "success.order_success"
        redirect_to carts_path
      else
        flash_slq_error @order
      end
    end
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit :order_status_id, :address, :address, :phone,
      :full_name
  end

  def flash_slq_error object
    flash[:danger] = object.errors.full_messages
    redirect_to :back
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

  def load_order
    @order = Order.find_by id: params[:id]
    unless @order
      flash[:danger] = t "error.order_not_found"
      redirect_to :back
    end
  end
end
