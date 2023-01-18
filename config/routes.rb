Rails.application.routes.draw do

  get 'initialization', to: 'application#initialization'

  resources :users, only: [:show] do
    post 'sign-in', on: :collection
    post 'sign-up', on: :collection
    get 'me', on: :collection
    patch 'like', on: :member
  end

  resources :conversations, only: [:index, :create, :update]

end
