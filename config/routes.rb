Rails.application.routes.draw do
  devise_for :users

  resources :tasks, param: :token do
    resources :runs, only: [:index, :create]
  end

  resources :runs, param: :token do
    member do
      put "cancel"
    end
  end

  get "pages/home"

  root "pages#home"
end
