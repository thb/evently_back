Rails.application.routes.draw do
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
  
  root "events#index"
end
