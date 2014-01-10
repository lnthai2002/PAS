Pas::Application.routes.draw do

  #engines
  mount Cooking::Engine => "/cooking"
  mount Financial::Engine => "/financial"  

  resources :songs
#  match 'songs/download/:id'=>'songs#download', :id => /[^\/]+/
  resources :users
  resources :groups

  root :to => 'songs#index'
  # See how all your routes lay out with "rake routes"

  delete 'logout', to: 'sessions#logout'

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  get ':controller(/:action(/:id(.:format)))'
end
