class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def add_to_cart
    session[:cart] ||= {}
    product = Product.find(params[:product_id])
    session[:cart][product.id.to_s] = { quantity: 1, price: product.price }
    binding.pry
  end
end
