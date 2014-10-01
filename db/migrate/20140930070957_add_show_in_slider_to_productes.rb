class AddShowInSliderToProductes < ActiveRecord::Migration
  def change
    add_column :products, :show_in_slider, :boolean, default: false
  end
end
