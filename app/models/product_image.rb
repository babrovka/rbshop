# == Schema Information
#
# Table name: product_images
#
#  id                 :integer          not null, primary key
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  product_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ProductImage < ActiveRecord::Base

  belongs_to :product

  has_attached_file :image, styles: {catalog: {geometry: "200x200#"},
                                     product: {geometry: "300x300#"},
                                     ico: {geometry: "70x70#"}
                                     }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  crop_attached_file :image


end
