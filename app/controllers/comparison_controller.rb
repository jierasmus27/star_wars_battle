class ComparisonController < ApplicationController
  before_action :set_entities, only: [:compare]

  def list
    begin
      @people = Person.all
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
    @primary   = Person.find_by_id(params[:primary_id])
    @secondary = Person.find_by_id(params[:secondary_id])
  end
end
