class Order < ActiveRecord::Base
  ## Associations
  belongs_to :user
  has_many :order_items
end
