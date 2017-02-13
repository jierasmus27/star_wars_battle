Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'comparison#list'

  post 'compare', to: 'comparison#compare', as: "compare"

  post 'compare_ships', to: 'comparison#compare_ships', as: "compare_ships"

end
