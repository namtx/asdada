class Admin::ProductsController < ApplicationController
  before_action :admin_user

  def index
    @products = Product.all
  end

  def new
  end

  def import
    Product.import params[:file]
    flash[:success] = "Successfully uploaded!"
    redirect_to admin_products_path
  end

  def show

  end
end
