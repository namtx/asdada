class CartController < ApplicationController
  def index
    @products = Product.all
  end
end
