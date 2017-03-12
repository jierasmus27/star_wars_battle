require 'rails_helper'

RSpec.feature "Display index of people", :type => :feature do
  feature 'User lists all people' do
    before :each do
      user = FactoryGirl.create(:user, :email => 'j@e.is.co.za', :password => 'something')
      login_as(user, :scope => :user)
    end

    scenario 'they see the people headings on the page' do
      visit new_series_people_path

      expect(page).to have_text("Name")
      expect(page).to have_text("Height")
      expect(page).to have_text("Mass")
      expect(page).to have_text("Hair color")
      expect(page).to have_text("Skin color")
      expect(page).to have_text("Eye color")
      expect(page).to have_text("Birth year")
      expect(page).to have_text("Gender")
    end

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
  end
end
