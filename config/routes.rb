Rails.application.routes.draw do
  root 'thoughts#index'
  resources :thoughts, only: [:index, :create] 
  resources :users, only: %i[new create show index] do
    resources :followings, only: [:create, :destroy], controller: 'followings'
    resources :bookmarks, only: [:create, :destroy, :index], controller: 'bookmarks'
  end
  get 'sign_up' => 'users#new'
  get 'sign_in'  => 'sessions#new'
  delete 'sign_out' => 'sessions#destroy'
  post 'sign_in' => 'sessions#create'
end
