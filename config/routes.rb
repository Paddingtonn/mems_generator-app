Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root :to => 'home#index'
  get '/login' => 'users#index'
  get '/logout' => 'sessions#destroy', as: "log_out"
  post '/sessions' => 'sessions#create'
  post '/users' => 'users#create'
  resources :shoes 
end
