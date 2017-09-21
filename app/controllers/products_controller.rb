class ProductsController < ApplicationController
  # before_action :authenticate_user!, except: [:index]

  def index
    @products = Product.all
  end

  def add_to_cart
    product = Product.find(params[:product_id])

    if current_user
      cart_item = Cart.find_or_initialise_by(product_id: product.id, user_id: current_user.id) 
      cart_item.quantity = cart_params[:quantity].to_i + 1
      cart_item.price = product.price
      cart_item.save
    else
      session[:cart] ||= {}

      session[:cart][product.id.to_s] = {
        quantity: session[:cart][product.id.to_s].try(:[], "quantity").to_i + 1,
        price: product.price
      }
    end
  end

  private

  def cart_params
    params.require(:cart).permit(:quantity)
  end
end
