module ComparisonHelper
  def people_status
    "disabled" if people_not_loaded
  end

  def starship_status
    "disabled" if starships_not_loaded
  end

  def entities_not_loaded
    entities = ""
    entities += "characters" if people_not_loaded
    entities += " and " if no_entities_loaded
    entities += "starships" if starships_not_loaded
    entities
  end

  def people_not_loaded
    @people.size < 1
  end

  def starships_not_loaded
    @starships.size < 1
  end

  def no_entities_loaded
    people_not_loaded && starships_not_loaded
  end

  def one_entity_not_loaded
    (people_not_loaded || starships_not_loaded) && !no_entities_loaded
  end

end
