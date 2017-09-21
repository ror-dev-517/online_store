class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def index
  	cart_products
  end

  def add_to_cart
    product = Product.find(params[:product_id])

    if current_user.present?
      cart_item = Cart.find_or_initialise_by(product_id: product.id, user_id: current_user.id) 
      cart_item.quantity = cart_item.quantity.to_i + (cart_params[:quantity] || 1)
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

  def checkout
    if session[:cart].present?
      session[:cart].each do |product_id, cart_hash|
        current_user.cart_items.create(product_id: product_id, quantity: cart_hash["quantity"], price: cart_hash["price"], total: (cart_hash["quantity"].to_i * cart_hash["price"].to_f))
      end
      session.delete(:cart)
    end
    @cart_products = current_user.cart_items
    @total = @cart_products.pluck(:price).map(&:to_f).inject(:+)
  end


  private

  def cart_params
    params.require(:cart).permit(:quantity)
  end

  def cart_products
    if current_user
      @cart_products = current_user.cart_items
      @total = @cart_products.pluck(:price).map(&:to_f).inject(:+)
    else
      if session[:cart].present?
        cart = []
        session[:cart].each do |product_id, cart_hash|
          cart << Cart.new(product_id: product_id, quantity: cart_hash["quantity"], price: cart_hash["price"])
        end
        @cart_products = cart
        @total = @cart_products.map{|c| c.price.to_f}.inject(:+)
      end
    end
  end
end
