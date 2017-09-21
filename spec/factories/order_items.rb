FactoryGirl.define do
  factory :order_item do
    order
    product
    price 1.5
    quantity 1
    total_amount 1.5
  end
end
