Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :requests, only: %i[index]
  resources :profiles, only: %i[show edit update]
  resources :matchings, only: %i[new create show edit update destroy]
  resources :partys, only: %i[index] do
    get 'detail', on: :collection
  end
end
