class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :load_user, only: :destroy

  def index
    @users = User.by_name_email(params[:keyword]).paginate page: params[:page],
      per_page: Settings.paginate.admin_users
  end

  def destroy
    if @user.destroy
      flash[:success] = t "success.delete"
      redirect_to admin_users_path
    else
      flash[:danger] = t "error.delete"
      redirect_to admin_users_path
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = "error.user_not_found"
      redirect_to admin_users
    end
  end
end
