Rails.application.routes.draw do
  root "lists#index"

  resources :pages, only: :show

  resources :lists, only: [:index, :show]

  namespace :api do
    namespace :v1 do
      resources :lists do
        resources :items
      end
    end
  end
end
