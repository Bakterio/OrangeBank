Rails.application.routes.draw do
  devise_for :usrs, controllers: {sessions: "usr/sessions"}
  get 'usr', to: 'accounts#redirect'
  root 'main#index'

  get 'main/about_us'
  get 'main/our_services'

  delete 'log_out', to: 'session#destory'

  get 'log_in', to: 'session#new'
  post 'log_in', to: 'session#create'

  resources :accounts

  get '/new_transaction', to: 'transactions#new'
  post '/new_transaction', to: 'transactions#create'

  get 'create_donate', to: 'donate#new'
  get 'qr_generator', to:'qr_transaction#generator'
  post 'qr_generator', to:'qr_transaction#generate'

  get 'debug', to: 'main#debug'
end
