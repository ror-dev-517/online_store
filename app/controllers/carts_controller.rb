class CartsController < ApplicationController
  # before_action :authenticate_user!

  def index
  	cart_products
  end

  def destroy_cart_item
    if current_user
      cart_item = Cart.find_by(product_id: params[:product_id], user_id: current_user.id)
      cart_item.destroy if cart_item.present?
    else
      if session[:cart].present?
        session[:cart].delete(params[:product_id])
      end
    end
    redirect_to carts_path
  end

  private

  def cart_products
    if current_user
      @cart_products = current_user.cart_items
      @total = @cart_products.pluck(:price).inject(:+)
    else
      if session[:cart].present?
        cart = []
        session[:cart].each do |product_id, cart_hash|
          cart << Cart.new(product_id: product_id, quantity: cart_hash["quantity"], price: cart_hash["price"])
        end
        @cart_products = cart
        @total = @cart_products.map(&:price).inject(:+)
      end
    end
  end
end
