class ComparisonController < ApplicationController
  include ComparisonHelper

  before_action :validate_allowed_entities, only: [:compare]
  before_action :set_entities, only: [:compare]

  def index
    @people = Person.all
    @starships = Starship.all

    flash[:warning] = "Some data could not be loaded for #{entities_not_loaded}" if one_entity_not_loaded
    flash[:danger] = "Data could not be loaded for #{entities_not_loaded}" if no_entities_loaded
  end

  def compare
    @results = @primary.compared_to(@secondary)
    render :partial => 'compare'
  rescue => e
    render :partial => 'error'
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
    raise "Incorrect entity passed" unless allowed_entities.include? params["entity"]
  end

  def allowed_entities
    ["person", "starship"]
  end

end
