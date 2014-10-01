FactoryGirl.define do
  
  sequence(:title) { |n| "Product #{n}" }
  
  factory :product do
    title { generate(:title) }
    price { rand(1000..10000) }
  end

end