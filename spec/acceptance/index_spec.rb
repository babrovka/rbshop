require 'acceptance_helper'

feature 'User works with index page' do

  it_behaves_like :real_productable do

    describe 'promos as slides' do
    end

    describe 'short brand links' do
      scenario 'opens page with products scoped by brand' do
        brands.each do |brand|
          # каждый раз заходим на главную страницу,
          # чтобы начать путь оттуда, а не со страницы продуктов
          visit root_path

          # кликаем по кнопке с логотипом бренда
          find("#spec-brand-link-#{brand.id}").click

          expect(current_path).to eq products_path

          # те товары, что должны быть
          Product.where(brand_id: brand.id).each do |product|
            expect(page).to have_content product.title
          end

          # те товары,что не должны быть
          Product.where.not(brand_id: brand.id).each do |product|
            expect(page).to_not have_content product.title
          end
        end
      end
    end

  end






end