class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :load_user, only: :destroy

  def index
    @users = User.by_name_email(params[:keyword]).paginate page: params[:page],
      per_page: 6
  end

  def destroy
    if @user.destroy
      flash[:success] = "Successfully deleted"
      redirect_to admin_users_path
    else
      flash[:danger] = "Delete failed"
      redirect_to admin_users_path
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = "User not found"
      redirect_to admin_users
    end
  end
end
