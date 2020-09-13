Rails.application.routes.draw do
  root 'thoughts#index'
  resources :thoughts, only: [:index, :create] do
    resources :bookmarks, only: [:create, :destroy]
  end
  resources :users, only: %i[new create show index]
  get 'sign_up' => 'users#new'
  get 'sign_in'  => 'sessions#new'
  delete 'sign_out' => 'sessions#destroy'
  post 'sign_in' => 'sessions#create'
end
