class SwapiEntityQuery
  def initialize(swapi_entity)
    @swapi_entity = swapi_entity
  end

  def find(id)
    Rails.cache.fetch("#{@swapi_entity.cache_name}/#{id}", expires_in: 25.minutes) do
      @swapi_entity.api_entity.find_by_id(id)
    end
  end

  private
  attr_reader :swapi_entity, :cache_name

end
