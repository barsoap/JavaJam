Rails.application.routes.draw do

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  # devise顧客用
  # URL /customers/sign_in ...
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }
  # devise管理者用
  # URL /admin/sign_in ...
  devise_for :admins, controllers: {
    registrations: "users/registrations",
    sessions: "admins/sessions"
  }

  #エンドユーザー用ルーティング
  scope module: :users do
    root to: 'homes#top'
    # 論理削除用のルーティング
    # patch '/users/:id/withdraw' => 'users#withdraw'
    resources :users, only: [:edit, :show, :update] do
      collection do
        patch 'withdraw'
      end
    end
    get 'recipes/tags', to: 'recipes#recipe_tags'
    resources :recipes do
      resources :recipe_comments, only:[:create, :destroy]
    end
    resources :notes
    resources :equipments
    get "/search", to: "searchs#search"
  end


  #管理者用ルーティング
  namespace :admins do
    root to: "homes#top"
    resources :users, only: [:show, :edit,:update] do
      patch "withdraw"
    end
    resources :recipes, only: [:index, :show, :destroy] do
      resources :recipe_comments, only: [:destroy]
    end
    resources :equipments, only: [:index, :show, :destroy]
    resources :notes, only: [:index, :show, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
