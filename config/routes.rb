Rails.application.routes.draw do

  #usersのルーティング
  scope module: :users do
    root to: 'homes#top'
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
