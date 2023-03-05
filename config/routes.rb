Rails.application.routes.draw do
  mount GoodJob::Engine => "jobs"

  devise_for :users

  resources :runs, only: :index

  resources :tasks, param: :uuid do
    resources :runs, param: :sequential_id do
      resources :assets, param: :filename, constraints: { filename: /.*/ }, only: [:index, :show]
      member do
        put "cancel"
      end
    end
  end

  get "pages/home"

  root "pages#home"
end
