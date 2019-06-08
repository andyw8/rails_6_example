Rails.application.routes.draw do
  root "pages#welcome"

  resources :pages, only: :show

  namespace :api do
    namespace :v1 do
      resources :items
    end
  end
end
