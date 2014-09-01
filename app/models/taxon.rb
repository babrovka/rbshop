class Taxon < ActiveRecord::Base
  self.table_name = "shop_taxons"

  enum taxon_type: [ :by_product_type, :by_care_type, :by_age ]

  belongs_to :taxonomy
  has_many :product_taxons
  has_many :products, through: :product_taxons

  acts_as_nested_set

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged


  default_scope { order('lft ASC') }
  scope :with_type, -> { where(taxon_type: nil) }
  scope :without, -> (id) { where.not(id: id) }
  
  def slug_candidates
    [
      :seo_url,
      [:seo_url, :title]
    ]
  end
end
