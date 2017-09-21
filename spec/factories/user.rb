FactoryGirl.define do
  factory :user, class: User do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'p@ssw0rd'
    password_confirmation 'p@ssw0rd'
    is_admin false
  end

  factory :admin, parent: :user do
    is_admin true
  end
end