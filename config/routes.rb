Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :songs, except: [:new, :edit]
      resources :artists, only: [:index, :show] do
        resources :songs, only: [:index, :create], controller: "artist_songs"
      end
      resources :images, only: :index, action: "show"
      resources :photographers, only: :index, action: "show"
    end
  end

end
