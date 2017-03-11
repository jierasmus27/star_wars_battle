class Entity

  def self.to_entity_array(api_val)
    api_val.collect{|a| self.new(a)}
  end

  def initialize(params = nil)
    to_obj(params) unless params.nil?
  end

  def to_obj(params)
    params.each_pair.each do |k, val|
      if (self.class.method_defined? "#{k}=")
        self.send("#{k}=", val)
      end
    end
    @id = self.class.extract_id(params.url)
  end

  def self.extract_id(url)
    raise "Not yet Implemented"
  end

  def self.api_entity
    raise "Not Yet Implemented"
  end

  def self.cache_name
    raise "Not yet Implemented"
  end

end
