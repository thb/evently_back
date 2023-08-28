Rails.application.routes.draw do
  use_doorkeeper
  resources :events
  resources :places
  resources :categories

  scope module: :api do
    namespace :v1 do
      resources :events
      resources :places
      resources :categories
    end
  end
  
  use_doorkeeper do
    controllers tokens: :access_token
  end
  
  devise_for :users

  root "events#index"
end
