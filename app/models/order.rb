class Order < ActiveRecord::Base
  ## Associations
  belongs_to :user
  has_many :order_items

  ## Callbacks
  after_save :destroy_cart_items

  def save_order_details
    gross_amount = 0

    self.user.cart_items.each do |cart_item|
      self.order_items.build(product_id: cart_item.product_id, price: cart_item.product.try(:price).to_f, quantity: cart_item.quantity, total_amount: cart_item.total)

      gross_amount += cart_item.total.to_f
    end

    self.gross_amount = gross_amount
    self.net_amount = gross_amount

    self.save
  end


  private

  def destroy_cart_items
    self.user.cart_items.where(product_id: self.order_items.pluck(:product_id)).delete_all
  end

end
