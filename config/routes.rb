Rails.application.routes.draw do
  root 'main#index'
  get 'main/about_us'
  get 'main/our_services'
  resources :users
end
