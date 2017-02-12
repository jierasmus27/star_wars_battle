class Person
  include Comparitor::Person

  attr_accessor :id, :name, :height, :mass, :hair_color, :skin_color, :birth_year, :gender, :homeworld,
                :eye_color, :films, :species, :vehicles, :starships, :created, :edited, :url

  def self.find_by_id(id)
    api_val = Rails.cache.fetch("swapi_rb3/#{id}", expires_in: 5.minutes) do
      SwapiRb::People.find_by_id(id)
    end
    Person.new(api_val)
  end

  def self.all
    api_val = Rails.cache.fetch("swapi_rb", expires_in: 25.minutes) do
      SwapiRb::People.all
    end
    to_people api_val
  end

  def self.to_people(api_val)
    api_val.collect{|a| Person.new(a)}
  end

  def initialize(params = nil)
    to_obj(params) unless params.nil?
  end

  def self.extract_id(url)
    url.match(/http:\/\/swapi.co\/api\/people\/(.*)\//)[1].to_i
  end

  def score
    score = 0
    score += films.count
    score += vehicles.count * 2
    score += starships.count * 2
    score += (height.to_i/50).round(0).to_i
    score += (mass.to_i/40).round(0).to_i
    score
  end

  def to_obj(params)
    params.each_pair.each do |k, val|
      if (Person.method_defined? "#{k}=")
        self.send("#{k}=", val)
      end
    end
    @id = Person.extract_id(params.url)
  end
end
