class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def index
  	cart_products
  end

  def add_to_cart
    product = Product.find(params[:product_id])

    if current_user.present?
      cart_item = current_user.cart_items.find_or_initialize_by(product_id: product.id, user_id: current_user.id)

      cart_item.update_cart(params[:product_quantity], product.price)
    else
      session[:cart] ||= {}
      session[:cart][product.id.to_s] = {
        quantity: (params[:product_quantity] || session[:cart][product.id.to_s].try(:[], "quantity").to_i + 1).to_i,
        price: product.price
      }
    end
    cart_products
  end


  def destroy_cart_item
    cart_item = Cart.find_by(product_id: params[:product_id], user_id: current_user.try(:id).to_i)

    if cart_item.present? || session[:cart].present?
      cart_item.destroy
      session[:cart].delete(params[:product_id])
      redirect_to carts_path, notice: "Product sucessfully removed from your cart."
    else
      redirect_to carts_path, error: "Product not found."
    end
  end

  def checkout
    if session[:cart].present?
      session[:cart].each do |product_id, cart_hash|
        cart_item = current_user.cart_items.find_or_initialize_by(product_id: product_id, user_id: current_user.id)

        cart_item.update_cart(cart_hash["quantity"], cart_hash["price"])
      end
      session.delete(:cart)
    end

    # @cart_products = Cart.get_cart_products(current_user)
    # @total = @cart_products.pluck(:price).map(&:to_f).inject(:+)
    cart_products
  end


  private

  def cart_products
    @cart_products = Cart.get_cart_products(current_user, session[:cart])
  end
end
