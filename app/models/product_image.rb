class ProductImage < ActiveRecord::Base
  belongs_to :product

  has_attached_file :image, styles: {catalog: {geometry: "200x200#"},
                                     product: {geometry: "300x300#"},
                                     ico: {geometry: "70x70#"}
                                     }

  crop_attached_file :image

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end