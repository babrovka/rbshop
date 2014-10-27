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
    by_care_type  = 2.times.map { create(:taxon, :by_care_type, taxonomy: taxonomies.sample) }
    by_age        = 3.times.map { create(:taxon, :by_age, taxonomy: taxonomies.sample) }
    by_product    = 4.times.map { create(:taxon, :by_product_type, taxonomy: taxonomies.sample) }
    (by_age + by_product + by_care_type).flatten
  end

  # создаем 10 товаров, чтобы быть точно уверенными,
  # что все они поместятся на одной странице в результатах выдачи
  # клеим к продуктам случайное количество таксонов
  let!(:products) do
    10.times.map do
      _taxons = rand(1..4).times.map{ taxons.sample }
      create(:product, brand: brands.sample, taxons: _taxons)
    end
  end

  let!(:sample_product) { products.sample }


end