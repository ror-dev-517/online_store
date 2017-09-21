FactoryGirl.define do
  factory :product, class: Product do
    sequence(:name) { |n| "Product #{n}"}
    price 10
  end
end