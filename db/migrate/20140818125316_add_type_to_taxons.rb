class AddTypeToTaxons < ActiveRecord::Migration
  def change
    add_column :shop_taxons, :taxon_type, :integer
  end
end
