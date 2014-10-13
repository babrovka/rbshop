FactoryGirl.define do
  
  sequence(:number) { |n| n }
  
  factory :product do
    sku { "sku #{generate :number}" }
    title { "Product #{generate :number}" }
    price { rand(1000..10000) }
    packing { 'packing' }
    short_description { Faker::Lorem.sentence }
    applying { Faker::Lorem.sentence }
    text { Faker::Lorem.sentence(10) }
    ingredients { Faker::Lorem.sentence }
    slug { "product_#{generate :number}_slug"}

    brand

    trait :with_taxons do
      taxons do
        rand(1..5).times.map { create(:taxon) }
      end
    end
  end

end