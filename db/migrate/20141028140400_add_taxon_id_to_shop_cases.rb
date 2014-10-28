class AddTaxonIdToShopCases < ActiveRecord::Migration
  def change
    add_column :shop_cases, :taxon_id, :integer
  end
end
