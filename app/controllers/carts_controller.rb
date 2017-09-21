class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def index
  	cart_products
  end

  def add_to_cart
    product = Product.find(params[:product_id])

    if current_user.present?
      cart_item = current_user.cart_items.find_or_initialize_by(product_id: product.id, user_id: current_user.id)
      cart_item.quantity = (params[:product_quantity] || cart_item.quantity.to_i + 1).to_i
      cart_item.price = product.price.to_f
      cart_item.total = (cart_item.quantity.to_i * product.price.to_f)
      cart_item.save
    else
      session[:cart] ||= {}
      session[:cart][product.id.to_s] = {
        quantity: (params[:product_quantity] || session[:cart][product.id.to_s].try(:[], "quantity").to_i + 1).to_i,
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
    redirect_to carts_path, notice: "Product sucessfully removed from your cart."
  end

  def checkout
    if session[:cart].present?
      session[:cart].each do |product_id, cart_hash|
        cart_item = current_user.cart_items.find_or_initialize_by(product_id: product_id, user_id: current_user.id)

        cart_item.quantity = cart_hash["quantity"].to_i
        cart_item.price = cart_hash["price"].to_f
        cart_item.total = (cart_hash["quantity"].to_i * cart_hash["price"].to_f)
        cart_item.save
      end
      session.delete(:cart)
    end
    @cart_products = current_user.cart_items
    @total = @cart_products.pluck(:price).map(&:to_f).inject(:+)
  end


  private

  def cart_products
    if current_user
      @cart_products = current_user.cart_items
      @total = @cart_products.pluck(:price).map(&:to_f).inject(:+)
    else
      if session[:cart].present?
        cart = []
        session[:cart].each do |product_id, cart_hash|
          cart << Cart.new(product_id: product_id, quantity: cart_hash["quantity"], price: cart_hash["price"], total: (cart_hash["quantity"].to_i * cart_hash["price"].to_f))
        end
        @cart_products = cart
        @total = @cart_products.map{|c| c.price.to_f}.inject(:+)
      end
    end
  end
end
