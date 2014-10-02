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