FactoryGirl.define do
  
  
  
  factory :product do
    id { generate :number }
    sku { "sku #{id}" }
    title { "Product #{id}" }
    price { rand(1000..10000) }
    packing { 'packing' }
    short_description { Faker::Lorem.sentence }
    applying { Faker::Lorem.sentence }
    text { Faker::Lorem.sentence(10) }
    ingredients { Faker::Lorem.sentence }
    slug { "product_#{id}_slug"}

    brand

    trait :with_taxons do
      taxons do
        rand(1..5).times.map { create(:taxon) }
      end
    end
  end

end