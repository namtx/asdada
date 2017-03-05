class SessionCart
  attr_accessor :session
  attr_accessor :products

  def initialize session
    self.session = session
    session[:current_cart] ||= {}
  end

  def add product, quantity
    session[:current_cart][product.id.to_s] ||= 0
    session[:current_cart][product.id.to_s] += quantity.to_i
  end

  def remove product
    session[:current_cart].tap {|current_cart| current_cart.delete(product.id.to_s) }
  end

  def size
    session[:current_cart].values.reduce(:+)
  end

  def quantity product
    session[:current_cart][product.id.to_s]
  end

  def products
    self.products = session[:current_cart].keys.map { |product_id| Product.find_by id: product_id.to_i }
  end

  def total
    session[:current_cart].sum {|product_id, quantity| Product.find_by(id: product_id.to_i).price * quantity.to_i}
  end

  def destroy
    session[:current_cart] = nil
  end
end
