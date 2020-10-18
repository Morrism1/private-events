Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  post '/attend', to: 'events#attend'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  resources :events
  resources :users, only: [:index, :new, :create, :show]
  resources :event_attendees
  root 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
