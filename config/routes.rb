Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'comparison#index'

  get 'compare/:entity', to: 'comparison#compare', as: "compare"

  resources :new_series_films, only: [:new, :create, :index, :show]

  resources :new_series_people, only: [:new, :create, :index, :show, :destroy]
end
