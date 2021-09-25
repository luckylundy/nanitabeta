Rails.application.routes.draw do 
  
  resources :microposts # 投稿に関するページ

  devise_for :users 
  root 'pages#index' # homeページ
  get 'explanation' => 'pages#show' # サイト説明ページ
  
  devise_scope :user do 
    post 'users/guest_sign_in', to: 'users/guest_sessions#new_guest' 
  end 
  resources :users, only: [:index, :show] # ユーザー一覧とユーザー詳細画面用 
end
