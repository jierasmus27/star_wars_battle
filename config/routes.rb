Rails.application.routes.draw do

  root 'comparison#index'

  get 'compare/:entity', to: 'comparison#compare', as: "compare"

  resources :new_series_films, only: [:new, :create, :index, :show]

  resources :new_series_people, only: [:new, :create, :index, :show, :destroy]
end
