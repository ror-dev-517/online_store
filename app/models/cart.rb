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

  def self.get_cart_products(user, cart_items)
    cart_products = []

    if user.present?
      cart_products = user.cart_items.order("created_at DESC")
    else
      if cart_items.present?
        cart_items.each do |product_id, cart_hash|
          cart_hash = cart_hash.symbolize_keys
          cart_products << self.new(product_id: product_id, quantity: cart_hash[:quantity], price: cart_hash[:price], total: (cart_hash[:quantity].to_i * cart_hash[:price].to_f) )
        end
      end
    end
    return cart_products
  end
end