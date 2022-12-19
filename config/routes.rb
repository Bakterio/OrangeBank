Rails.application.routes.draw do
  root 'main#index'

  get 'main/about_us'
  get 'main/our_services'

  get "sing_up", to: "registration#new"
  post "sing_up", to: "registration#create"
  delete "log_out", to: "session#destory"

  get "debug", to: "main#debug"
end
