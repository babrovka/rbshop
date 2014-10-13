# == Schema Information
#
# Table name: shop_cases
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  text               :text
#  short_description  :text
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  slug               :string(255)
#  seo_url            :string(255)
#  seo_title          :string(255)
#  seo_description    :text
#  created_at         :datetime
#  updated_at         :datetime
#

class Case < ActiveRecord::Base
  def self.table_name_prefix
    'shop_'
  end
  
  has_and_belongs_to_many :products, join_table: "shop_cases_products"
  
  has_attached_file :image, styles: {medium: "940x380#", banner: "620x220#"}
  do_not_validate_attachment_file_type :image
  
  scope :ordered, -> (field) {order(field)}
  
  extend FriendlyId
  friendly_id :seo_url, use: :slugged
end
