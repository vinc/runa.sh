Rails.application.routes.draw do
  mount GoodJob::Engine => "jobs"

  devise_for :users

  resources :tasks, param: :uuid do
    resources :runs, param: :sequential_id do
      member do
        put "cancel"
      end
    end
  end

  get "pages/home"

  root "pages#home"
end
