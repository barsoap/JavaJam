Rails.application.routes.draw do

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

    # namespace :users do
  #   get 'users/edit'
  #   get 'users/show'
  # end
  #usersのルーティング(URL変えない場合)
  scope module: :users do
    root to: 'homes#top'
    # 論理削除用のルーティング
    # patch '/users/:id/withdraw' => 'users#withdraw'
    resources :users, only: [:edit, :show, :update] do
      collection do
        patch 'withdraw'
      end
    end
    resources :recipes, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :notes, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
