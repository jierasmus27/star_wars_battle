class ComparisonController < ApplicationController
  before_action :set_people, only: [:compare]
  before_action :set_starships, only: [:compare_ships]

  def list
    begin
      @people = Person.all
      @starships = Starship.all
    rescue => e
      render :template => 'error'
    end
  end

  def compare
    begin
      @results = @primary.compared_to(@secondary)

      render :partial => 'compare'
    rescue => e
      render :partial => 'error'
    end
  end

  def compare_ships
    begin
      @results = @primary.compared_to(@secondary)

      render :partial => 'compare'
    rescue => e
      render :partial => 'error'
    end
  end

  private

  def set_people
    @primary   = Person.find_by_id(params[:primary_id])
    @secondary = Person.find_by_id(params[:secondary_id])
  end

  def set_starships
    @primary   = Starship.find_by_id(params[:primary_ship_id])
    @secondary = Starship.find_by_id(params[:secondary_ship_id])
  end
end
