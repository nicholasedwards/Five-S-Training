Rails.application.routes.draw do

  root 'static_pages#home'
  get 'about' => 'static_pages#about' 

  resources :users, only: [:new, :create, :show] 

end
