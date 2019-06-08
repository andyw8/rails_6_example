Rails.application.routes.draw do
  root "pages#welcome"

  resources :pages, only: :show

  resources :todos
end
