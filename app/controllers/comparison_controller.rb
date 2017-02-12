class ComparisonController < ApplicationController
  before_action :set_entities, only: [:compare]

  def list
    @people = Person.all
  end

  def compare
    @results = @primary.compared_to(@secondary)

    render :partial => 'compare'
  end

  private

  def set_entities
    @primary   = Person.find_by_id(params[:primary_id])
    @secondary = Person.find_by_id(params[:secondary_id])
  end
end
