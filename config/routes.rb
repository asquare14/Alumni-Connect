Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  authenticated :user do
    root to: 'home#signedin', as: :authenticated_root
  end
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
