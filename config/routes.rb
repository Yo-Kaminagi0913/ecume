Rails.application.routes.draw do
  # アプリ稼働確認用
  get "up" => "rails/health#show", as: :rails_health_check

  # ルート
  root to: 'posts#index'

  # サインアップ
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # ログイン/ログアウト
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # ユーザ情報（マイページ）
  resources :users, only: [:new, :create, :show], path_names: { show: 'profile' }

  # 投稿
  resources :posts, only: [:index, :new, :create, :show] do
    collection do
      # 24時間以内の投稿一覧
      get 'recent', to: 'posts#recent'
      # お気に入り投稿一覧
      get 'favorites', to: 'posts#favorites'
    end

    # お気に入り登録/解除
    resource :favorite, only: [:create, :destroy]
  end
end
