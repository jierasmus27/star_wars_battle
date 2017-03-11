class ComparisonController < ApplicationController
  include ComparisonHelper

  before_action :validate_allowed_entities, only: [:compare]
  before_action :set_primary_and_secondary, only: [:compare]

  def index
    @people = set_entities(Person)
    @starships = set_entities(Starship)

    flash[:warning] = "The functionality for comparing #{entities_not_loaded} is temporarily unavailable, as the data could be loaded" if one_entity_not_loaded
    flash[:danger] = "The functionality for comparing both #{entities_not_loaded} is temporarily unavailable, as no data could be loaded" if no_entities_loaded
  end

  def compare
    @results = @primary.compared_to(@secondary)
    render :partial => 'compare'
  rescue => e
    render :partial => 'error'
  end

  private

  def set_primary_and_secondary
    @primary = set_entity(params[:primary_id])
    @secondary = set_entity(params[:secondary_id])
  end

  def set_entity(id)
    response = SwapiEntityQuery.new(entity_class).find(id)
    entity_class.new(response)
  end

  def set_entities(entity)
    response = SwapiEntitiesQuery.new(entity).call
    entity.to_entity_array(response)
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
