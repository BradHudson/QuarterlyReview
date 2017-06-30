Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  # get 'sessions/create'
  get   '/login', :to => 'sessions#new', :as => :login
  get '/logout', :to => 'sessions#destroy'
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
