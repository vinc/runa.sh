Rails.application.routes.draw do
  devise_for :users

  resources :tasks do
    resources :runs
  end
  resources :runs

  get "pages/home"

  root "pages#home"
end
