module Comparitor
  module Person
    def compare(primary, secondary)
      winner = "It is a tie"
      winner = primary.name if Person.score(primary) > Person.score(secondary)
      winner = secondary.name if Person.score(primary) < Person.score(secondary)

      strengths = []
      strengths << "has more mass" if primary.mass.to_i > secondary.mass.to_i
      strengths << "is taller" if primary.length.to_i > secondary.length.to_i
      strenghts << "has been in more films" if primary.films.count > secondary.films.count
      strenghts << "can drive more vehicles" if primary.vehicles.count > secondary.vehicles.count
      strenghts << "can fly more starships" if primary.starships.count > secondary.starships.count

      weaknesses = []
      weaknesses << "has less mass" if primary.mass.to_i < secondary.mass.to_i
      weaknesses << "is shorter" if primary.length.to_i < secondary.length.to_i
      weaknesses << "has been in fewer films" if primary.films.count < secondary.films.count
      weaknesses << "can drive fewer vehicles" if primary.vehicles.count < secondary.vehicles.count
      weaknesses << "can fly fewer starships" if primary.starships.count < secondary.starships.count

      {"winner" => winner, "strenghts" => strengths, "weaknesses" => weaknesses}
    end
  end
end
