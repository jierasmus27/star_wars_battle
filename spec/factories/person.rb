FactoryGirl.define do
  factory :person, class: Person do
    skip_create

    birth_year { "19 BBY" }
    eye_color { "Blue" }
    gender {"Male"}
    hair_color {"Blond"}
    homeworld {"http://swapi.co/api/planets/1/"}
    skin_color {"Fair"}
    created {"2014-12-09T13:50:51.644000Z"}
    edited {"2014-12-10T13:52:43.172000Z"}
    species {[
        "http://swapi.co/api/species/1/"
    ]}

    trait :luke_skywalker do
      id { 1 }
      mass {"77"}
      name {"Luke Skywalker"}
      height {"172"}
      starships {[
          "http://swapi.co/api/starships/12/"
      ]}
      url {"http://swapi.co/api/people/1/"}
      vehicles { [
          "http://swapi.co/api/vehicles/14/"
      ] }
      films { [
          "http://swapi.co/api/films/1/"
      ] }
    end

    trait :c3po do
      id { 2 }
      mass {"75"}
      name {"C-3PO"}
      height {"167"}
      starships {[ ]}
      url {"http://swapi.co/api/people/2/"}
      vehicles { [ ] }
      films { [
        "http://swapi.co/api/films/5/",
        "http://swapi.co/api/films/4/",
        "http://swapi.co/api/films/6/",
        "http://swapi.co/api/films/3/",
        "http://swapi.co/api/films/2/",
        "http://swapi.co/api/films/1/"
      ] }
    end
  end
end
