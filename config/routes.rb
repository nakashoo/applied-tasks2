Rails.application.routes.draw do
  devise_for :users
  root :to =>"homes#top"

  get "home/about"=>"homes#about", as: 'about'

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :follows, :followers
    end
      resource :relationships, only: [:create, :destroy]
  end

  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end