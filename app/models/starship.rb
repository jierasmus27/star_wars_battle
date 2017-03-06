class Starship < Entity
  include Comparitor::Starship

  attr_accessor :id, :name, :model, :manufacturer, :cost_in_credits, :length, :max_atmosphering_speed, :crew, :passengers, :cargo_capacity,
                :consumables, :hyperdrive_rating, :starship_class, :pilots, :films, :created, :edited, :url

  def self.extract_id(url)
    url.match(/http:\/\/swapi.co\/api\/starships\/(.*)\//)[1].to_i
  end

  def self.api_entity
    SwapiRb::Starship
  end

  def self.cache_name
    "swapi_rb_starship"
  end

end
