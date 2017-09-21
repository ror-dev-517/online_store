class Cart < ActiveRecord::Base
  ## Associations
  belongs_to :user
  belongs_to :product

  def update_cart(product_quantity = nil, product_price = nil)
    qty = (product_quantity || self.quantity.to_i + 1).to_i

    self.quantity = qty
    self.price = product_price.to_f
    self.total = qty * product_price.to_f
    self.save
  end
end