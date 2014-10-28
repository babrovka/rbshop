# == Schema Information
#
# Table name: shop_taxons
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  taxonomy_id     :integer
#  parent_id       :integer
#  lft             :integer
#  rgt             :integer
#  depth           :integer
#  slug            :string(255)
#  seo_title       :string(255)
#  seo_description :text
#  seo_text        :text
#  seo_url         :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  taxon_type      :integer          default(0)
#

class Taxon < ActiveRecord::Base
  self.table_name = "shop_taxons"

  enum taxon_type: [ :by_product_type, :by_care_type, :by_age ]

  belongs_to :taxonomy
  has_many :product_taxons
  has_many :products, through: :product_taxons

  acts_as_nested_set

  extend FriendlyId
  friendly_id :title, use: :slugged
  
  validates :taxonomy_id, presence: true


  default_scope { order('lft ASC') }
  scope :with_type, -> { where(taxon_type: nil) }
  scope :without, -> (id) { where.not(id: id) }
  scope :ordered, -> (field) {order(field)}
  scope :allowed_parent, -> { where(depth: 0) }
  
  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end
end
