module Comparitor
  module Person
    include Comparable

    def <=>(secondary)
      score <=> secondary.score
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

    def compared_to(secondary)
      winner = "It is a tie"
      winner = name if score > secondary.score
      winner = secondary.name if score < secondary.score

      strengths = []
      strengths << "#{name} has more mass" if mass.to_i > secondary.mass.to_i
      strengths << "#{name} is taller" if height.to_i > secondary.height.to_i
      strengths << "#{name} has been in more films" if films.count > secondary.films.count
      strengths << "#{name} can drive more vehicles" if vehicles.count > secondary.vehicles.count
      strengths << "#{name} can fly more starships" if starships.count > secondary.starships.count

      weaknesses = []
      weaknesses << "#{name} has less mass" if mass.to_i < secondary.mass.to_i
      weaknesses << "#{name} is shorter" if height.to_i < secondary.height.to_i
      weaknesses << "#{name} has been in fewer films" if films.count < secondary.films.count
      weaknesses << "#{name} can drive fewer vehicles" if vehicles.count < secondary.vehicles.count
      weaknesses << "#{name} can fly fewer starships" if starships.count < secondary.starships.count

      ties = []
      ties << "#{name} and #{secondary.name} have equal mass" if mass.to_i == secondary.mass.to_i
      ties << "#{name} and #{secondary.name} are equally all" if height.to_i == secondary.height.to_i
      ties << "#{name} and #{secondary.name} have been in an equal amount of films" if films.count == secondary.films.count
      ties << "#{name} and #{secondary.name} can drive the same number of vehicles" if vehicles.count == secondary.vehicles.count
      ties << "#{name} and #{secondary.name} can fly the same amount of starships" if starships.count == secondary.starships.count

      {"winner" => winner, "strengths" => strengths, "weaknesses" => weaknesses, "ties" => ties}
    end
  end
end
