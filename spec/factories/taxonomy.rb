FactoryGirl.define do
  
  factory :taxonomy do
    title { "Taxonomy #{generate :number}" }
    seo_title { "taxonomy seo title #{generate :number}" }
    seo_text { "taxonomy seo text #{generate :number}" }
    seo_description { "taxonomy seo description #{generate :number}" }
    slug { "taxonomy_#{generate :number}_slug" }
  end

end