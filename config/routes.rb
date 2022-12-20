Rails.application.routes.draw do
  resources :transactions
  root 'main#index'

  get 'main/about_us'
  get 'main/our_services'

  get "sign_up", to: "registration#new"
  post "sign_up", to: "registration#create"
  delete "log_out", to: "session#destory"

  get "log_in", to: "session#new"
  post "log_in", to: "session#create"

  resources :accounts

  get "debug", to: "main#debug"
end
