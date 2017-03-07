class Admin::SuggestedProductsController < ApplicationController
  before_action :admin_user
  before_action :load_suggested_product, only: :destroy
  before_action :get_price_params, only: :index
  def index
    @suggested_products = SuggestedProduct.by_name_description(params[:keyword])
      .by_min_price(@min_price)
      .by_max_price(@max_price)
      .paginate page: params[:page], per_page: 5
  end

  def destroy
    if @suggested_product.destroy
      flash[:success] = t "success.delete_successed"
      redirect_to admin_suggested_products_path
    else
      flash[:danger] = t "error.delete_failed"
      redirect_to admin_suggested_products_path
    end
  end

  private

  def load_suggested_product
    @suggested_product =  SuggestedProduct.find_by id: params[:id]
    unless @suggested_product
      flash[:danger] = t "error.suggested_product_not_found"
      redirect_to admin_suggested_products_path
    end
  end

  def get_price_params
    price_str = params[:price]
    @max_price = price_str.split(",").last if price_str.present?
    @min_price = price_str.split(",").first if price_str.present?
  end
end
