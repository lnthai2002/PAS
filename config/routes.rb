# See how all your routes lay out with "rake routes"
Pas::Application.routes.draw do
  #engines
  mount Cooking::Engine => "/cooking"
  mount Financial::Engine => "/financial"
  mount Music::Engine => "/music"

  resources :groups
  resources :users

  root :to => 'users#index'

  delete 'logout', to: 'sessions#logout'
end
