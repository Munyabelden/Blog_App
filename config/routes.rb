Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        get 'posts', on: :member
      end
      resources :posts, only: [:index, :show], defaults: { format: :json } do
        resources :comments, only: [:index, :create], defaults: { format: :json }
      end
    end
  end
end
