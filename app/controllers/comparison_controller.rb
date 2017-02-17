class ComparisonController < ApplicationController
  before_action :validate_allowed_entities, only: [:compare]
  before_action :set_entities, only: [:compare]

  def index
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

  private

  def set_entities
    @primary = entity_class.find_by_id(params[:primary_id])
    @secondary = entity_class.find_by_id(params[:secondary_id])
  end

  def entity_class
    params["entity"].capitalize.constantize
  end

  def validate_allowed_entities
    raise ArgumentError "Incorrect entity passed" unless allowed_entities.include? params["entity"]
  end

  def allowed_entities
    ["person", "starship"]
  end
end
