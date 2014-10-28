FactoryGirl.define do
  
  factory :brand do
    id { generate :number }
    title { "Brand #{id}" }
  end

end