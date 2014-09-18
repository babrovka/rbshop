class Case < ActiveRecord::Base
  def self.table_name_prefix
    'shop_'
  end
  
  has_and_belongs_to_many :products, join_table: "shop_cases_products"
  
  has_attached_file :image, styles: {medium: "940x380#", banner: "620x220#"}
  do_not_validate_attachment_file_type :image
  
  extend FriendlyId
  friendly_id :seo_url, use: :slugged
end
