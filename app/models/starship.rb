class Starship
  include Comparitor::Starship

  attr_accessor :id, :name, :model, :manufacturer, :cost_in_credits, :length, :max_atmosphering_speed, :crew, :passengers, :cargo_capacity,
                :consumables, :hyperdrive_rating, :starship_class, :pilots, :films, :created, :edited, :url

  def self.find_by_id(id)
    api_val = Rails.cache.fetch("swapi_rb_ship/#{id}", expires_in: 5.minutes) do
      SwapiRb::Starship.find_by_id(id)
    end
    Starship.new(api_val)
  end

  def self.all
    api_val = Rails.cache.fetch("swapi_rb_ship", expires_in: 25.minutes) do
        SwapiRb::Starship.all
    end
    to_starships api_val
  rescue => e
    Rails.logger.error "Starship error received: #{e.message}"
    return []
  end

  def self.to_starships(api_val)
    api_val.collect{|a| Starship.new(a)}
  end

  def initialize(params = nil)
    to_obj(params) unless params.nil?
  end

  def self.extract_id(url)
    url.match(/http:\/\/swapi.co\/api\/starships\/(.*)\//)[1].to_i
  end

  def to_obj(params)
    params.each_pair.each do |k, val|
      if (Starship.method_defined? "#{k}=")
        self.send("#{k}=", val)
      end
    end
    @id = Starship.extract_id(params.url)
  end
end
