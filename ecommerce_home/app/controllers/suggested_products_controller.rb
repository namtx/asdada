class SuggestedProductsController < ApplicationController
  before_action :load_suggested_product, only: [:destroy, :edit, :update]

  def new
    @suggested_product = current_user.suggested_products.new
  end

  def create
    @suggested_product = current_user.suggested_products.new suggested_product_params
    if @suggested_product.save
      flash[:success] = "Thank you for your suggest"
      redirect_to controller: :users, action: :show, id: current_user.id, tab: :suggested_product_tab
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @suggested_product.update_attributes suggested_product_params
      flash[:success] = "Successfully edited"
      redirect_to controller: :users, action: :show, id: current_user.id, tab: :suggested_product_tab
    else
      flash[:danger] = "Something went wrong"
      redirect_to :back
    end
  end

  def destroy
    if @suggested_product.destroy
      flash.now[:success] = "Successfully deleted"
    else
      flash[:danger] = "Delete failed"
      redirect_to :back
    end
  end

  private

  def load_suggested_product
    @suggested_product = current_user.suggested_products.find_by id: params[:id]
    unless @suggested_product
      flash[:danger] = "Suggested product not found"
      redirect_to :back
    end
  end

  def suggested_product_params
    params.require(:suggested_product).permit :name, :content, :price, :image
  end
end
