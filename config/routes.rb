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

  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash
  
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
  
  authenticated :user do
    root 'posts#hobby', as: :authenticated_root
  end

  root 'pages#index'

end
