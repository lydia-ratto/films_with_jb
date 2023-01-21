Rails.application.routes.draw do
  root to: "films#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :films
  
end
