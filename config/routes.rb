Time2ghost::Application.routes.draw do
  root :to => 'homepage#index'
  resources :trips
  resources :users
end
