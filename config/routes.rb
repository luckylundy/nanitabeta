Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  devise_for :users
  root 'pages#index'
  get 'pages/show'

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/guest_sessions#new_guest'
  end

  resources :users, only: [:index, :show]
end
