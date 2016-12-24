Rails.application.routes.draw do

  root 'static_pages#home'

  get 'about' => 'static_pages#about' 

  get 'signup' => 'users#new'

  get 'confirm_deletion' => 'users#confirm_deletion'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

  resources :users, only: [:create, :edit, :update, :destroy] 

  resources :lessons, only: [:show, :index]

  resources :lesson_completions, only: [:create]

  resources :account_activations, only: [:edit]

end
