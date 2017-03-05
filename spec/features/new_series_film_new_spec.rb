require 'rails_helper'

RSpec.feature "Create new films", :type => :feature do
  feature 'User creates a new film' do
    scenario 'they see the form on the page' do
      visit new_new_series_film_path

      expect(page).to have_text("Episode")
      expect(page).to have_text("Opening crawl")
      expect(page).to have_text("Director")
      expect(page).to have_text("Producer")
    end

    scenario 'a user can create a new film' do
      visit new_new_series_film_path

      fill_in 'Episode', with: '10'
      fill_in 'Opening crawl', with: 'Far faar faaar away'
      fill_in 'Director', with: 'Ridley Scott'
      fill_in 'Producer', with: 'Brian Singer'
      fill_in 'Release date', with: '09/03/2017'
      click_button 'Create New series film'

      expect(page).to_not have_text("error")
    end
  end
end
