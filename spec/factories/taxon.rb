FactoryGirl.define do
  
  factory :taxon do
    title { "Taxon #{generate :number}" }
    seo_title { "taxon seo title #{generate :number}" }
    seo_text { "taxon seo text #{generate :number}" }
    seo_description { "taxon seo description #{generate :number}" }
    slug { "taxon_#{generate :number}_slug" }

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