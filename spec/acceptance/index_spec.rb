require 'acceptance_helper'

feature 'manage index ' do

  describe 'brands link', js: true do
    scenario '' do
      visit root_path
      expect(page).to have_content 'бренды'
    end
  end

end