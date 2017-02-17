Rails.application.routes.draw do

  root 'comparison#index'

  get 'compare/:entity', to: 'comparison#compare', as: "compare"

end
