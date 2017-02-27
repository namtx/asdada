class UsersController < ApplicationController
  before_action :load_user, only: [:show]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
    else
      render :new
    end
  end
  def show
    @products = Product.all.paginate page: params[:page], per_page: 5
  end

  def edit
    @user = User.first
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
  end

  def user_params
    params.require(:user).permit :user_name, :email, :password,
      :password_confirmation, :profile_image
  end
end
