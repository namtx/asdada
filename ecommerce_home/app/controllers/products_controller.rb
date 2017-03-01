class ProductsController < ApplicationController
  def index
    price_str = params[:price]
    @max_price = price_str.split(",").last if price_str.present?
    @min_price = price_str.split(",").first if price_str.present?
    @products = Product.by_sub_category(params[:sub_category])
    .by_min_price(@min_price).by_max_price(@max_price)
    if params[:rate].present?
      @products = @products.select do |product|
        product.average_rate > params[:rate].to_i
      end
    end
    @products = @products.paginate page: params[:page], per_page: 12
  end

  def show
    @product = Product.find_by id: params[:id]
  end

  private

end
