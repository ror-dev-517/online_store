FactoryGirl.define do
  factory :order do
    user
    gross_amount 1.5
    tax_amount 1.5
    discount_amount 1.5
    net_amount 1.5
  end
end
