Time2ghost::Application.routes.draw do
  root :to => 'homepage#index'
  resources :trips
  resources :users
  resources :sessions, :only => [:create, :delete]
  get 'twiliotest', to: 'twilio#show'
end
