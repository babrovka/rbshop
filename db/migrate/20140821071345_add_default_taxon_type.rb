class AddDefaultTaxonType < ActiveRecord::Migration
  def change
    change_column :shop_taxons, :taxon_type, :integer, default: 0
  end
end
