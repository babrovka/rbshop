# Создаем почти реальную коллекцию объектов товаров
# как на продакшене, только с фейковыми параметрами
shared_examples :real_productable do

  let!(:brands) do
    3.times.map { create(:brand) }
  end

  let!(:taxonomies) do
    4.times.map { create(:taxonomy) }
  end

  let!(:taxons) do
    by_age = 5.times.map { create(:taxon, :by_age, taxonomy: taxonomies.sample) }
    by_product = 20.times.map { create(:taxon, :by_product_type, taxonomy: taxonomies.sample) }
    by_care_type = 7.times.map { create(:taxon, :by_care_type, taxonomy: taxonomies.sample) }
    (by_age + by_product + by_care_type).flatten
  end

  # создаем 19 товаров, чтобы быть точно уверенными,
  # что все они поместятся на одной странице в результатах выдачи
  let!(:products) do
    19.times.map do
      _taxons = rand(1..4).times.map{ taxons.sample }
      create(:product, brand: brands.sample, taxons: _taxons)
    end
  end

  let!(:product) { products.sample }


end