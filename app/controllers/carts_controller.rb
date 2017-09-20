class CartsController < ApplicationController
  def index
  	@cart_products = Product.all
  end
end
