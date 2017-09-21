class OrderItem < ActiveRecord::Base
  ## Associations
  belongs_to :order
end
