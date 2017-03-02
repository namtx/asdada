module CartsHelper

  def current_order
    if !session[:order_id].nil?
      Order.find_by id: session[:order_id]
    else
      Order.new
    end
  end
end
