Rails.application.routes.draw do
  constraints subdomain: "get" do
    get "/", to: redirect("/runa.sh")
    match "(*any)", to: redirect(ENV["RUNA_URL"]), via: :all
  end

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

  get "download", to: "pages#download"

  root "pages#home"
end
