Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      root to: "pages#home"
      resources :films
      get "bungard", to: "pages#bungard"
    end
  end
end
