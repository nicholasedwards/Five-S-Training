Rails.application.routes.draw do

  root 'static_pages#home'

  get 'about' => 'static_pages#about' 

  get 'signup' => 'users#new'

  get 'login' => 'sessions#new'

  get 'lessons' => 'lessons#index'

  resources :users, only: [:create] 

end