class NewSeriesPeopleController < ApplicationController
  before_action :set_new_series_person, only: [:destroy, :show]

  def new
    @new_series_person = NewSeriesPerson.new
  end

  def create
    @new_series_person = NewSeriesPerson.new(new_series_person_params)

    respond_to do |format|
      if @new_series_person.save
        format.html { redirect_to @new_series_person, notice: 'New Series Person was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def show
  end

  def index
    @new_series_people = NewSeriesPerson.all
  end

  def destroy
    @new_series_person.destroy
    respond_to do |format|
      format.html { redirect_to new_series_people_url, notice: 'User was successfully destroyed.' }
      format.js
    end
  end

  private

  def new_series_person_params
    params.require(:new_series_person).permit(:name, :height, :mass, :hair_color, :skin_color, :eye_color, :birth_year, :gender)
  end

  def set_new_series_person
    @new_series_person = NewSeriesPerson.find(params[:id])
  end

end
