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

require 'rails_helper'

describe Taxon do
  
  describe '#taxon' do
    
    context 'slug' do
      it "is generates correctly" do
        title = 'особый заголовок для таксона'
        parameterized_title = title.parameterize
        t = Taxon.create!(title: title, taxonomy_id: 1)
        t.reload
        expect(t.slug).to eq parameterized_title
      end
    end
  
  end
  
  
    
end
