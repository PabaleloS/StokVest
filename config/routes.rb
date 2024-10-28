Rails.application.routes.draw do
  get 'paystack/callback'
  get 'paystack/webhook'
  devise_for :users
  root to: "stokvels#index"
  get "up" => "rails/health#show", as: :rails_health_check

  post "stokvel/:stokvel_id/payout", to: "payouts#create", as: :create_payout
  post "stokvel/:id/create-members", to: "members#create_members", as: :create_members

  resources :stokvels, except: [:edit, :update] do
    resources :members, only: [:index, :new, :show, :create, :destroy]
    resources :messages, only: %i[index create]
    resources :transactions, only: %i[new create show]
    resources :users, only: %i[index]
    resources :contributions, only: [:index, :show, :new, :create]
    resources :payouts, only: [:index, :show, :new, :create]
  end
  resources :members, only: %i[update]

  resources :transactions, only: [:index] do
    member do
      get 'show_contribution'
      get 'show_payout'
    end
  end

  post "stokvels/:id/accept_invite", to: "stokvels#accept_invite", as: :accept_invite
  post "stokvels/:id/decline_invite", to: "members#declined", as: :decline_invite

  post '/paystack/callback', to: 'paystack#callback'
  post '/paystack/webhook', to: 'paystack#webhook'
end
