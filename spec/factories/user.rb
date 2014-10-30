FactoryGirl.define do
  
  sequence(:email) { |n| "username_#{n}@mail.com" }

  factory :user do
    email { generate(:email) }
    first_name 'first_name'
    last_name 'last_name'
    password 'password'
    password_confirmation 'password'
  end

end