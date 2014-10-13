# == Schema Information
#
# Table name: slides
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  text               :text
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  product_id         :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Slide < ActiveRecord::Base
  belongs_to :product
  scope :for_allowed_products, -> { includes(:product).where(:products => {:show_in_slider => true}) }
  
  # has_attached_file :image, styles: {slide: {geometry: "1200х700#"},
  #                                    slide_preview: {geometry: "100х100#"}
  #                                    }
  has_attached_file :image, styles: {slide: {geometry: "1200x700#"},
                                     preview: {geometry: "100x100#"}
  }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  crop_attached_file :image
end
