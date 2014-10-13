# == Schema Information
#
# Table name: shop_taxonomies
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  slug            :string(255)
#  seo_title       :string(255)
#  seo_description :text
#  seo_text        :text
#  created_at      :datetime
#  updated_at      :datetime
#

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
