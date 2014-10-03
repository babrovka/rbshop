FactoryGirl.define do

  factory :cart do
  end

  factory :cart_with_products, parent: :cart do
    before(:create) do |instance|
      rand(1..7).times do |i|
        product = create(:product)
        LineItem.create!(cart_id: instance.id, product_id: product.id)
      end
    end
  end


end