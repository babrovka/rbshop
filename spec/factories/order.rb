FactoryGirl.define do

  factory :order do
  end

  factory :order_with_products, parent: :order do
    before(:create) do |instance|
      rand(1..7).times do |i|
        product = create(:product)
        LineItem.create!(order_id: instance.id, product_id: product.id)
      end
    end
  end


end