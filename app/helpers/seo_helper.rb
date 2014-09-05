module SeoHelper
  def title
     base_title = "Royal Brands shop"
     if @title.present?
       "#{@title} | #{base_title}"
     else
       base_title
     end
   end
   
   def meta_description
     base_meta_description = ""
     if @meta_description.present?
       @meta_description
     else
       base_meta_description
     end
   end
   
end
