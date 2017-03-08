class Supports::UserSupport
  attr_reader :user

  def initialize user
    @user = user
  end

  def recently_viewed_products
    @user.recently_viewed_products
  end

  def orders
    @user.orders
  end

  def suggested_products
    @user.suggested_products
  end
end
