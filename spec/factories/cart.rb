FactoryGirl.define do
  factory :cart do
    product
    user
    quantity 1
    price 10
    total 10
  end
end