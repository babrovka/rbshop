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