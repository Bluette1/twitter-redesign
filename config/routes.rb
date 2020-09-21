Rails.application.routes.draw do
  root 'thoughts#index' 
  resources :thoughts, only: [:index, :create] do
    resources :bookmarks, only: [:create], controller: 'bookmarks'
  end
  resources :users, only: %i[create show] do
    resources :followings, only: [:create, :destroy], controller: 'followings'
    resources :bookmarks, only: [:destroy, :index], controller: 'bookmarks'
  end
  get 'sign_up' => 'users#new'
  get 'sign_in'  => 'sessions#new'
  delete 'sign_out' => 'sessions#destroy'
  post 'sign_in' => 'sessions#create'
  resources :trends, only: %i[index]
end
