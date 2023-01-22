Rails.application.routes.draw do
  root to: "films#index"
  get "bungard", to: "pages#bungard"
  resources :films
  
end
