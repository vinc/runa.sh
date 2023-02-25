Rails.application.routes.draw do
  devise_for :users

  resources :tasks do
    resources :runs, only: [:index, :create]
  end

  resources :runs do
    member do
      put "cancel"
    end
  end

  get "pages/home"

  root "pages#home"
end
