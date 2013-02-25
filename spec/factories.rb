FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "Person #{n}"}
    sequence(:email) {|n| "example_#{n}@overtherainbow.com"}
    password "password"
    password_confirmation "password"
  end
end
