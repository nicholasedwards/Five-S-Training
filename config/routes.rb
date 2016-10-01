Rails.application.routes.draw do

  get 'sessions/new'

  get 'lessons/index'

  root 'static_pages#home'
  get 'about' => 'static_pages#about' 

  resources :users, only: [:new, :create] 
  resources :lessons, only: [:index]
  resources :sessions, only: [:new]

end
