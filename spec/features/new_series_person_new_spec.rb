require 'rails_helper'

RSpec.feature "Create new People", :type => :feature do
  feature 'User creates a new person' do
    scenario 'they see the form on the page' do
      visit new_new_series_person_path

      expect(page).to have_text("Name")
      expect(page).to have_text("Height")
      expect(page).to have_text("Mass")
      expect(page).to have_text("Hair color")
      expect(page).to have_text("Skin color")
      expect(page).to have_text("Eye color")
      expect(page).to have_text("Birth year")
      expect(page).to have_text("Gender")
    end

    scenario 'a user can create a new person' do
      visit new_new_series_person_path

      fill_in 'Name', with: 'Obi-two'
      fill_in 'Height', with: '1.89'
      fill_in 'Mass', with: '100'
      fill_in 'Hair color', with: 'Brown'
      fill_in 'Skin color', with: 'Purple'
      fill_in 'Eye color', with: 'Blue'
      fill_in 'Birth year', with: '1998'
      fill_in 'Gender', with: 'Male'
      click_button 'Create New series person'

      expect(page).to_not have_text("error")
      expect(page).to have_text("New Series Person Name: Obi-two")
    end
  end
end
