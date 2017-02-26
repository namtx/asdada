class UsersController < ApplicationController
  before_action :load_user, only: [:show]
  def index
    @users = User.all
  end

  def show
  end
  private
  def load_user
    @user = User.find_by id: params[:id]
    flash[:info] = "Alo Alo"
  end
end
