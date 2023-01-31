Rails.application.routes.draw do
  devise_for :usrs
  get "usr", to: "accounts#redirect"
  root 'main#index'

  get 'main/about_us'
  get 'main/our_services'

  delete "log_out", to: "session#destory"

  get "log_in", to: "session#new"
  post "log_in", to: "session#create"

  resources :accounts

  get "/new_transaction", to: "transactions#new"
  post "/new_transaction", to: "transactions#create"

  get "create_donate", to: "donate#new"

  get "debug", to: "main#debug"
end
