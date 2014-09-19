class Taxonomy < ActiveRecord::Base
  self.table_name = "shop_taxonomies"
  has_many :taxons
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  scope :ordered, -> (field) {order(field)}
  
  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end
end
