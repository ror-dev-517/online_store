FactoryGirl.define do
  factory :order_item do
    order_id 1
    product_id 1
    price 1.5
    quantity 1
    total_amount 1.5
  end
end
