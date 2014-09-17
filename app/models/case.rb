class Case < ActiveRecord::Base
  def self.table_name_prefix
    'shop_'
  end
  
  has_and_belongs_to_many :products, join_table: "shop_cases_products"
end
