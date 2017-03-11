class NewSeriesPeopleController < ApplicationController
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
    @new_series_person = NewSeriesPerson.find(params[:id])
  end

  def index
    @new_series_people = NewSeriesPerson.all
  end

  private

  def new_series_person_params
    params.require(:new_series_person).permit(:name, :height, :mass, :hair_color, :skin_color, :eye_color, :birth_year, :gender)
  end

end
