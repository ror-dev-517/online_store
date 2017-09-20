class Cart < ActiveRecord::Base
  ## Associations
  belongs_to :user
  belongs_to :product
end
