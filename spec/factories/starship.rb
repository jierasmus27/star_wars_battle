FactoryGirl.define do
  factory :starship, class: Starship do
    skip_create

    model { "Sentinel-class landing craft" }
    manufacturer { "Sienar Fleet Systems, Cyngus Spaceworks" }
    cost_in_credits { "240000" }
    consumables { "1 month" }
    mglt { "70" }
    starship_class { "landing craft" }
    pilots { [] }
    films { [
      "http://swapi.co/api/films/1/"
    ] }
    created { "2014-12-10T15:48:00.586000Z" }
    edited { "2014-12-22T17:35:44.431407Z" }

    trait :sentinel do
      name { "Sentinel-class landing craft" }
      hyperdrive_rating { "1.0" }
      length { "38" }
      max_atmosphering_speed { "1000" }
      crew { "5" }
      passengers { "75" }
      cargo_capacity { "180000" }
      url { "http://swapi.co/api/starships/5/" }
    end

    trait :death_star do
      name { "Death Star" }
      hyperdrive_rating { "4.0" }
      length { "120000" }
      max_atmosphering_speed { "1" }
      crew { "342953" }
      passengers { "843342" }
      cargo_capacity { "1000000000000" }
      url { "http://swapi.co/api/starships/9/" }
    end
  end
end
