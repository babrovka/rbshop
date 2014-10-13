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

require 'rails_helper'

describe Taxonomy do
  
  describe '#taxonomy' do
    
    context 'slug' do
      it "is generates correctly" do
        title = 'особый заголовок для таксономии'
        parameterized_title = title.parameterize
        t = Taxonomy.create!(title: title)
        t.reload
        expect(t.slug).to eq parameterized_title
      end
    end
  
  end
  
  
    
end
