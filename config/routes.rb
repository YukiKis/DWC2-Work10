Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  resources :users, only: [:show,:index,:edit,:update] do
    get :followings, :followers
  end
  get "books/search"
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end


  resources :relationships, only: [:create, :destroy]
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'

  resources :chats, only: :create
  resources :rooms, only: [:create, :show]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end