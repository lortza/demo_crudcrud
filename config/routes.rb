Rails.application.routes.draw do

  root "posts#index"

  resources :posts do
    resources :comments, :defaults => { :commentable => 'Post' }
  end
  resources :photos do
    resources :comments, :defaults => { :commentable => 'Photo' }
  end

  resources :sessions, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  resources :tags

  resources :users do
    # resources :addresses
  end

  resources :comments
  put "update_comments" => 'comments#update_comments'
  patch "update_comments" => 'comments#update_comments'

  resources :friendings, :only => [:create, :destroy]

  resources :photos, :only => [:new, :create, :show] do
    get "serve"
  end
end
