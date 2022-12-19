Rails.application.routes.draw do
  get "sing_up", to: "registration#new"
  post "sing_up", to: "refistration#create"
  root 'main#index'
  get 'main/about_us'
  get 'main/our_services'
end
