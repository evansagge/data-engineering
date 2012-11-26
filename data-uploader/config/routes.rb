DataUploader::Application.routes.draw do
  resources :purchases, only: :index
  resources :merchants
  resources :items, only: %w(index show)
  resources :people
  resources :records, only: %w(index create show destroy)

  resource :user, only: :show

  match "/login" => "sessions#new", as: :login
  match "/logout" => "session#destroy", as: :logout

  root to: "records#index"
end
