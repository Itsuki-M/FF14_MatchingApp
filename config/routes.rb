Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :requests, only: %i[index]
  resources :profiles, only: %i[show edit update]
  resources :matchings
  resources :parties, only: %i[index] do
    get 'detail', on: :collection
  end
  resources :chat_rooms, only: %i[show] do
    resources :chat_messages, only: %i[create]
  end
  get 'blocks/confirm/:blocked_user_id', to: 'blocks#confirm', as: 'confirm_block'
  resources :blocks, only: %i[create destroy index]
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index show edit update destroy]
  end
  resources :password_resets, only: %i[new create edit update]
  resources :notifications, only: %i[index update] do
    collection do
      delete :mark_all_as_read
    end
  end
  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
  mount ActionCable.server => '/cable'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
