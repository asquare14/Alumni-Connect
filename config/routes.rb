Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  resources :expertises 
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
    get 'mentor', to: 'devise/registrations#mentor'
    get 'mentee', to: 'devise/registrations#mentee'
  end

  resource :registrations do
    devise_scope :user do
      get 'mentor'
      get 'mentee'
    end
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

  root 'pages#index'
  resources :expertise_users, only: [:new, :create]

  get 'expertise_users/show_mentors', to: 'expertise_users#show_mentors'
  post 'expertise_users/select_mentor', to: 'expertise_users#select_mentor'  
  get 'expertise_users/show_selected_mentor', to: 'expertise_users#show_selected_mentor'
  get 'expertise_users/show_mentees', to: 'expertise_users#show_mentees' 
end
