Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Active Admin
  ActiveAdmin.routes(self)

  # Devise authentication
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # API endpoints
  namespace :api do
    namespace :v1 do
      get "users", to: "users#index"
      post "status", to: "status#update"
      patch "status", to: "status#update"
      get "config", to: "config#show"
    end
  end

  # Main application routes
  root "dashboard#index"
  get "kiosk", to: "dashboard#kiosk"
  get "dashboard", to: "dashboard#index"

  # Action Cable
  mount ActionCable.server => "/cable"
end
