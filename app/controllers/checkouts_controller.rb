class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def place_order
    order = current_user.orders.build
    gross_amount = 0

    current_user.cart_items.each do |cart_item|
      order.order_items.build(product_id: cart_item.product_id, price: cart_item.product.try(:price).to_f, quantity: cart_item.quantity, total_amount: cart_item.total)

      gross_amount += cart_item.total.to_f
    end

    order.gross_amount = gross_amount
    order.net_amount = gross_amount

    if order.save
      current_user.cart_items.delete_all
      redirect_to root_path, notice: "Your Order has been placed successfully."
    else
      redirect_to root_path, alert: "Something went wrong while processing your order."
    end
  end
end
