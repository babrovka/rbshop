class Slide < ActiveRecord::Base
  belongs_to :product
  scope :for_allowed_products, -> { includes(:product).where(:products => {:show_in_slider => true}) }
  
  has_attached_file :image, styles: {slide: {geometry: "1200х700#"},
                                     slide_preview: {geometry: "100х100#"}
                                     }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
