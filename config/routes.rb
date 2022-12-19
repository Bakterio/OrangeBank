Rails.application.routes.draw do
  root 'main#index'

  get 'main/about_us'
  get 'main/our_services'

  get "sign_up", to: "registration#new"
  post "sign_up", to: "registration#create"
  delete "log_out", to: "session#destory"

  get "log_in", to: "session#new"
  post "log_in", to: "session#create"

  namespace :accounts do 
    get "new"
  end

  get "debug", to: "main#debug"
end
