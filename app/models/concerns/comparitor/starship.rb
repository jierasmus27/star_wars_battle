module Comparitor
  module Starship
    include Comparable

    def <=>(secondary)
      score <=> secondary.score
    end

    def score
      score = 0
      score += length.to_i
      score += crew.to_i
      score += max_atmosphering_speed.to_i
      score += hyperdrive_rating.to_i
      score += passengers.to_i
      score += cargo_capacity.to_i
      score
    end

    def compared_to(secondary)
      winner = "It is a tie"
      winner = name if score > secondary.score
      winner = secondary.name if score < secondary.score

      strengths = []
      strengths << "#{name} is a longer ship" if length.to_i > secondary.length.to_i
      strengths << "#{name} can carry more crew" if crew.to_i > secondary.crew.to_i
      strengths << "#{name} has higher atmosperic speed" if max_atmosphering_speed.to_i > secondary.max_atmosphering_speed.to_i
      strengths << "#{name} has a better hyperdrive rating" if hyperdrive_rating.to_i > secondary.hyperdrive_rating.to_i
      strengths << "#{name} can carry more passengers" if passengers.to_i > secondary.passengers.to_i
      strengths << "#{name} can carry more cargo" if cargo_capacity.to_i > secondary.cargo_capacity.to_i

      weaknesses = []
      weaknesses << "#{name} is a shorter ship" if length.to_i < secondary.length.to_i
      weaknesses << "#{name} can carry fewer crew" if crew.to_i < secondary.crew.to_i
      weaknesses << "#{name} has lower atmosperic speed" if max_atmosphering_speed.to_i < secondary.max_atmosphering_speed.to_i
      weaknesses << "#{name} has a worse hyperdrive rating" if hyperdrive_rating.to_i < secondary.hyperdrive_rating.to_i
      weaknesses << "#{name} can carry fewer passengers" if passengers.to_i < secondary.passengers.to_i
      weaknesses << "#{name} can carry less cargo" if cargo_capacity.to_i < secondary.cargo_capacity.to_i

      ties = []
      ties << "#{name} and #{secondary.name} has equal length" if length.to_i == secondary.length.to_i
      ties << "#{name} and #{secondary.name} can carry equal crew" if crew.to_i == secondary.crew.to_i
      ties << "#{name} and #{secondary.name} has equal atmosperic speed" if max_atmosphering_speed.to_i == secondary.max_atmosphering_speed.to_i
      ties << "#{name} and #{secondary.name} has an equal hyperdrive rating" if hyperdrive_rating.to_i == secondary.hyperdrive_rating.to_i
      ties << "#{name} and #{secondary.name} can carry the same amount of passengers" if passengers.to_i == secondary.passengers.to_i
      ties << "#{name} and #{secondary.name} can carry equal cargo" if cargo_capacity.to_i == secondary.cargo_capacity.to_i

      {"winner" => winner, "strengths" => strengths, "weaknesses" => weaknesses, "ties" => ties}
    end
  end
end
