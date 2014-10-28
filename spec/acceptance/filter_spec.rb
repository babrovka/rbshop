require 'acceptance_helper'

feature 'User filters products by it attributes' do

  # функция быстрого выбора пункта из фильтра
  # очень жестко настроена на работу с Ransack
  def select_filter_attr(type, id)
    find("label[for='q_#{type}_id_in_#{id}']").click
  end

  # выбираем параметр в фильтре
  # и проверяем, что в подсказе нужное число товаро показано
  def select_and_check_attr(type, id, count)
    # вначале щелкаем по одному фильтру
    within '.spec-filter' do
      select_filter_attr type, id
    end
    sleep 1

    # смотрим на всплывающую подсказку поиска
    within '.spec-filter-hint' do
      expect(page).to have_content "Найдено #{count}"
      click_on 'Показать'
      expect(current_path).to eq path
    end
  end


  # Огромный шаблон поведения фильтра
  shared_examples_for :filterable do

    background do
      # Делаем проверку на то, что таксоны
      # не совпадают в тех колллекциях товаров,
      # которые тестируем
      expect(other_taxons.count).to be > 0
      other_taxons.each do |other_taxon|
        similar_taxons.each do |similar_taxon|
          expect(similar_taxon).to_not eq other_taxon
        end
      end

      visit path
    end

    context 'With same taxons in products' do
      scenario 'User sees products list with one selected taxon' do
        # щелкаем по одному параметру фильтра
        select_and_check_attr :taxons, similar_taxons.first.id, 2
      end

      scenario 'User sees products list with several selected taxons' do
        select_and_check_attr :taxons, similar_taxons.first.id, 2
        select_and_check_attr :taxons, similar_taxons.second.id, 2
      end

      after do
        # после подгрузки страницы с фильтрацией,
        # убеждаемся, что только нужные товары отфильтровались
        expect(page).to have_content similar_product1.title
        expect(page).to have_content similar_product2.title

        expect(page).to_not have_content product3.title
        expect(page).to_not have_content product4.title
        expect(page).to_not have_content product5.title
      end
    end

    context 'With mismatched taxons in products' do
      scenario 'User sees empty products list with several selected taxon' do
        select_and_check_attr :taxons, similar_taxons.first.id, 2
        select_and_check_attr :taxons, other_taxons.first.id, 0

        expect(page).to_not have_content similar_product1.title
        expect(page).to_not have_content similar_product2.title
        expect(page).to_not have_content product3.title
        expect(page).to_not have_content product4.title
        expect(page).to_not have_content product5.title
      end
    end

  end

  describe 'Filter with several same taxons', js: true do

    context 'All products with random brand' do

      # описываем особенные товары, потому что нам важно ручное тестирование фильтра
      # создаем мало товаров, чтобы быть точно уверенными,
      # что все они поместятся на одной странице в результатах выдачи
      # клеим к продуктам случайное количество таксонов
      let!(:brands) do
        3.times.map { create(:brand) }
      end

      let!(:taxonomies) do
        2.times.map { create(:taxonomy) }
      end

      let(:taxonomy) { taxonomies.first }

      let!(:other_taxons) do
        [create(:taxon, :by_care_type, taxonomy: taxonomy),
        create(:taxon, :by_age, taxonomy: taxonomy),
        create(:taxon, :by_product_type, taxonomy: taxonomy)]
      end

      # делаем три таксона, чтобы по первым двум фильтровать
      # а по последнему открыть страницу и тестировать работу там
      let!(:similar_taxons) do
        [create(:taxon, :by_care_type, taxonomy: taxonomy),
        create(:taxon, :by_care_type, taxonomy: taxonomy),
        create(:taxon, :by_product_type, taxonomy: taxonomy)]
      end

      let(:taxon_for_path) { similar_taxons.last }

      let!(:similar_product1) { create(:product, brand: brands.sample, taxons: similar_taxons) }
      let!(:similar_product2) { create(:product, brand: brands.sample, taxons: similar_taxons) }
      let!(:product3) { create(:product, brand: brands.sample, taxons: [other_taxons.sample]) }
      let!(:product4) { create(:product, brand: brands.sample, taxons: [other_taxons.sample]) }
      let!(:product5) { create(:product, brand: brands.sample, taxons: [other_taxons.sample]) }

      context 'Page with all products' do
        let(:path) { products_path }

        it_should_behave_like :filterable
      end

      context 'Taxon page' do
        let(:path) { taxon_path(taxon:taxon_for_path, taxonomy: taxonomy) }
        it_should_behave_like :filterable

        describe 'Filter products by taxons in main menu' do
          scenario 'Users sees only taxons products' do
            visit path

            expect(page).to have_content similar_product1.title
            expect(page).to have_content similar_product2.title
            expect(page).to_not have_content product3.title
            expect(page).to_not have_content product4.title
            expect(page).to_not have_content product5.title
          end
        end
      end

      context 'Taxonomy page' do
        describe 'Filter products by taxonomy in main menu' do
          let(:path) { taxonomy_path(taxonomy) }
          let!(:another_taxonomy){ create(:taxonomy) }
          let!(:another_taxons){ [create(:taxon, :by_care_type), create(:taxon, :by_product_type)] }
          let!(:another_product) { create(:product, taxons: another_taxons) }

          it_should_behave_like :filterable

          scenario 'Users sees only taxonomy taxons products' do
            visit path

            expect(page).to have_content similar_product1.title
            expect(page).to have_content similar_product2.title
            expect(page).to have_content product3.title
            expect(page).to have_content product4.title
            expect(page).to have_content product5.title

            expect(page).to_not have_content another_product.title
          end
        end
      end

    end

  end

  describe 'Filter with several brands', js: true do

    let(:brand) { create(:brand) }
    let(:another_brand) { create(:brand) }

    let(:taxonomy) { create(:taxonomy) }

    let!(:taxons) do
      [create(:taxon, :by_care_type, taxonomy: taxonomy),
       create(:taxon, :by_product_type, taxonomy: taxonomy)]
    end

    let!(:another_taxons) do
      [create(:taxon, :by_care_type, taxonomy: taxonomy),
       create(:taxon, :by_age, taxonomy: taxonomy)]
    end

    let!(:products) do
      2.times.map{ create(:product, brand: brand, taxons: taxons) }
    end

    let!(:another_products) do
      3.times.map { create(:product, brand: another_brand, taxons: [another_taxons.sample]) }
    end

    let(:path) { products_path }

    scenario 'User sees products by several brands' do
      visit path

      select_and_check_attr :brand, brand.id, products.count
      select_and_check_attr :brand, another_brand.id, products.count + another_products.count

    end

    scenario 'User sees products by several brands and one taxon' do
      visit path

      select_and_check_attr :brand, brand.id, products.count
      select_and_check_attr :brand, another_brand.id, products.count + another_products.count

      select_and_check_attr :taxons, taxons.first.id, products.count
    end

  end

end