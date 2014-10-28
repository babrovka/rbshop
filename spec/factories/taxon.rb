FactoryGirl.define do
  sequence(:number) { |n| n }
  
  factory :taxon, class: Taxon do
    id { generate :number }
    title { "Taxon #{id}" }
    seo_title { "taxon seo title #{id}" }
    seo_text { "taxon seo text #{id}" }
    seo_description { "taxon seo description #{id}" }
    slug { "taxon_#{id}_slug" }

    taxonomy

    trait :by_age do
      taxon_type :by_age
    end

    trait :by_product_type do
      taxon_type :by_product_type
    end

    trait :by_care_type do
      taxon_type :by_care_type
    end

  end

end