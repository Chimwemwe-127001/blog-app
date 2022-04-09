Rails.application.routes.draw do
  root 'users#index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :create, :new, :show]
  end
  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts, only: %i[new create update destroy] do
    resources :comments
      resources :likes
  end   

  namespace :api do
    namespace :v1 do
      post 'users/sign_in' => 'users#login'
      get 'posts' => 'posts#index'
      get 'comments' => 'comments#index'
      post 'comments/create' => 'comments#create'
    end
  end
end
