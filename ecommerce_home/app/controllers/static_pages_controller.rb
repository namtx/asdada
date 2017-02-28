class StaticPagesController < ApplicationController
  def home
    @hot_trends = Product.all.take(10)
  end
end
