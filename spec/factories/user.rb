FactoryGirl.define do
  
  sequence(:email) { |n| "username_#{n}@mail.com" }

  factory :user do
    email { generate(:email) }
    password 'password'
    password_confirmation 'password'
  end

end