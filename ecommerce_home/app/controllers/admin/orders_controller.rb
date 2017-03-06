class Admin::OrdersController < ApplicationController
  before_action :load_order, only: [:show, :destroy, :update]

  def index
    @orders = Order.by_status_id(params[:status_id]).paginate page: params[:page],
      per_page: 6
  end

  def show
    
  end

  def update
    if @order.update_attribute(:order_status_id, params[:status_id].to_i)
      flash[:success] = "Successfully shipped"
      redirect_to admin_orders_path
    else
      flash[:danger] = "Update failed"
      redirect_to admin_order_path
    end
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    unless @order
      flash[:danger] = "Order not found"
      redirect_to admin_orders_path
    end
  end
end
