Rails.application.routes.draw do
  resources :customers
  resources :products
  resources :users
  get    'sign_in'   => 'sessions#new'
  post   'sign_in'   => 'sessions#create'
  delete 'sign_out'  => 'sessions#destroy'

  root 'sessions#new'
end