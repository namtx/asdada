class CartsController < ApplicationController
  before_action :update_session_cart, only: [:create, :update]
  before_action :destroy_session_cart, only: [:destroy]
  def create
  end

  def update
  end

  def destroy
  end

  def index
  end

  private

  def update_session_cart
    load_product
    if is_out_of_stock?
      flash.now[:danger] = "Product is out of stock"
    else
      @current_cart = current_cart
      @current_cart.add @product, params[:quantity]
      @product.update_attribute :quantity, @product.quantity - params[:quantity].to_i
    end
  end

  def destroy_session_cart
    load_product
    @current_cart = current_cart
    @product.update_attribute :quantity, @product.quantity + @current_cart.quantity(@product)
    @current_cart.remove @product
  end

  def is_out_of_stock?
    @product.quantity < params[:quantity].to_i
  end

  def load_product
    @product = Product.find_by id: params[:product_id].to_i
    unless @product
      flash.now[:danger] = "Product not found"
      redirect_to :back
    end
  end
end
