class AddBoughtToProducts < ActiveRecord::Migration
  def change
    add_column :products, :bought, :integer, default: 0
  end
end
