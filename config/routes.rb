# See how all your routes lay out with "rake routes"
Pas::Application.routes.draw do
  #engines
  mount Casum::Engine => "/casum"
  mount Cooking::Engine => "/cooking"
  mount Financial::Engine => "/financial"
  mount Music::Engine => "/music"
end
