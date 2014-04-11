Time2ghost::Application.routes.draw do
  resources :users
  get 'twiliotest', to: 'twilio#show'
end
