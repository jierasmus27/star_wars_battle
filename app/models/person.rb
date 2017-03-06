class Person < Entity
  include Comparitor::Person

  attr_accessor :id, :name, :height, :mass, :hair_color, :skin_color, :birth_year, :gender, :homeworld,
                :eye_color, :films, :species, :vehicles, :starships, :created, :edited, :url

  def self.extract_id(url)
    url.match(/http:\/\/swapi.co\/api\/people\/(.*)\//)[1].to_i
  end

  def self.api_entity
    SwapiRb::People
  end

  def self.cache_name
    "swapi_rb_person"
  end

end
