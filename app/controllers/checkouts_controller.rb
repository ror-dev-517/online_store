class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def place_order
    order = current_user.orders.build

    if order.save_order_details
      redirect_to root_path, notice: "Your Order has been placed successfully."
    else
      redirect_to root_path, alert: "Something went wrong while processing your order."
    end
  end
end
