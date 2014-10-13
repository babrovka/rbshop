FactoryGirl.define do
  
  factory :brand do
    title { "Brand #{generate :number}" }
  end

end