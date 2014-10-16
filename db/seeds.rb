%w(brand_1 brand_2 brand_3 by_care_type by_age).each do |name|
  Hint.create!(name: name)
end

puts 'hints added'


if Rails.env.development?
  unless Brand.exists?
    3.times { FactoryGirl.create(:brand) }
  end
  Rake::Task['data:admin_and_user'].invoke
  Rake::Task['data:taxonomies'].invoke
  Rake::Task['data:nested_taxons'].invoke
  Rake::Task['data:special_taxons'].invoke

  # создаем продукты и привязываем их
  unless Product.exists?
    25.times { FactoryGirl.create(:product, brand: Brand.all.sample) }
  end
  Rake::Task['data:taxons_to_products'].invoke
end