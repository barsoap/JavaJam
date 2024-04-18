Rails.application.routes.draw do

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  # devise_for :admins
  # devise_for :users
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admins, controllers: {
    registrations: "users/registrations",
    sessions: "admins/sessions"
  }

  scope module: :users do
    root to: 'homes#top'
    # 論理削除用のルーティング
    # patch '/users/:id/withdraw' => 'users#withdraw'
    resources :users, only: [:edit, :show, :update] do
      collection do
        patch 'withdraw'
      end
    end
    resources :recipes, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :recipe_comments, only:[:create, :destroy]
    end
    resources :notes, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :equipments, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    get "/search", to: "searchs#search"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
