class UsersController < ApplicationController
  before_action :load_user, only: [:show]
  before_action :correct_user, only: [:edit, :update, :show]
  def index
    @users = User.order_by_name.paginate page: params[:id],
      per_page: 15
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      login @user
      flash[:success] = t "signup.success"
      redirect_to @user
    else
      render :new
    end
  end
  def show
    @recently_viewed_products = recently_viewed_products.reverse
  end

  def edit
  end

  def update
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "user_not_found"
      redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit :user_name, :email, :password,
      :password_confirmation, :profile_image
  end

  def correct_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "user_not_found"
      redirect_to root_url
    else
      unless @user == current_user
        flash[:danger] = t "user_not_found"
        redirect_to root_url
      end
    end
  end
end
