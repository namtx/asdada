class RatingsController < ApplicationController
  before_action :logged_in_user
  def create
    @rating = Rating.find_or_initialize_by product_id: params[:product_id],
      user_id: current_user.id
    @rating.update_attributes rating_params
  end

  private
  def rating_params
    params.require(:rating).permit :point
  end
end
