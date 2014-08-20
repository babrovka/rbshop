class AddApplyingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :applying, :string
  end
end
