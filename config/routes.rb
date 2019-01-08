Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end
  
  resources :posts do
    collection do
      get 'hobby'
      get 'study'
      get 'team'
    end
  end
  
  resources :posts do
    resources :comments
  end
  
  resources :posts do
    member do
      put "like", to: "posts#upvote"
      put "dislike", to: "posts#downvote"
    end
  end   
  
  resources :groups
  
  authenticated :user do
    root 'posts#hobby', as: :authenticated_root
  end
  
  namespace :private do 
    resources :conversations, only: [:create] do
      member do
        post :close
      end
    end
    resources :messages, only: [:index, :create]
  end
  
  root 'pages#index'
  
end
