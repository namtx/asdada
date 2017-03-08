class Admin::ProductsController < ApplicationController
  before_action :admin_user
  before_action :load_product, only: [:edit, :update, :destroy, :show]
  before_action :get_price_params, only: :index

  def index
    @products = Product.by_sub_category(params[:sub_category])
      .by_classification(params[:classsification])
      .by_name(params[:name])
      .by_min_price(@min_price)
      .by_max_price(@max_price)
    if params[:rate].present?
      @products = @products.select do |product|
        product.average_rate >= params[:rate].to_i
      end
    end
    @products = @products.paginate page: params[:page],
      per_page: Settings.paginate.admin_products
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "success.update"
      redirect_to [:admin, @product]
    else
      flash[:danger] = t "error.update_failed"
      redirect_to admin_products_path
    end
  end

  def show
  end

  def destroy
    if @product.destroy
      flash[:success] = t "success.delete"
      redirect_to admin_products_path
    else
      flash[:danger] = t "error.detele"
      redirect_to admin_products_path
    end
  end

  def import
    if Product.import?(params[:file])
      flash[:success] = t "success.upload"
      redirect_to admin_products_path
    else
      flash[:danger] = t "error.upload"
      redirect_to admin_products_path
    end
  end

  private

  def product_params
    params.require(:product).permit :name, :description, :price, :quantity,
      :image, :sub_category_id
  end

  def load_product
    @product = Product.find_by id: params[:id]
  end

  def get_price_params
    price_str = params[:price]
    @max_price = price_str.split(",").last if price_str.present?
    @min_price = price_str.split(",").first if price_str.present?
  end
end
