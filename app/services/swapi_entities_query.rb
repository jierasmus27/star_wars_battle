class SwapiEntitiesQuery
  def initialize(swapi_entity)
    @swapi_entity = swapi_entity
  end

  def call
    Rails.cache.fetch("#{@swapi_entity.cache_name}", expires_in: 25.minutes) do
      @swapi_entity.api_entity.all
    end
  end

  private
  attr_reader :swapi_entity, :cache_name

end
