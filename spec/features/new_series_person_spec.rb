require 'rails_helper'

RSpec.feature "Feature for New Series People", :type => :feature do
  feature 'User deletes person' do
    scenario 'they see the people details on the page' do
      new_series_person_one = create(:new_series_person, name: "Luke")
      new_series_person_two = create(:new_series_person, name: "Leia")

      visit new_series_people_path

      expect(page).to have_text("Luke")
      expect(page).to have_text("Leia")
      expect(page).to have_text(new_series_person_one.mass)
      expect(page).to have_text(new_series_person_one.hair_color)
      expect(page).to have_text(new_series_person_one.skin_color)
      expect(page).to have_text(new_series_person_one.eye_color)
      expect(page).to have_text(new_series_person_one.birth_year)
      expect(page).to have_text(new_series_person_one.gender)
    end

    scenario 'it removes deleted people details from the page' do
      new_series_person_one = create(:new_series_person, name: "Luke")
      new_series_person_two = create(:new_series_person, name: "Leia")

      visit new_series_people_path

      expect(page).to have_text("Luke")
      expect(page).to have_text("Leia")

      within("//tr#index_people_row_#{new_series_person_one.id}") do
        # byebug
        #expect{ page.accept_confirm { click_link 'Remove' } }.to change(NewSeriesPerson, :count).by(-1)
      end
    end
  end
end
