class ProductsController < ApplicationController

  def index
    @products = Product.all
  end
  
  def show
    @product = Product.find_by id: params[:id]
    @rating = Rating.find_by product: @product, user_id: 2
    @rate_count = @product.ratings.size
  end
end
