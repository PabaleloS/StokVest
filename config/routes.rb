Rails.application.routes.draw do
  devise_for :users
  # devise_for :users
  root to: "stokvels#index"
  get "up" => "rails/health#show", as: :rails_health_check # health check

  post "stokvel/:id/payout", to: "stokvel#payout", as: :payout
  post "stokvel/:id/create-members", to: "members#create_members", as: :create_members

  resources :stokvels, except: [:edit, :destroy, :update] do
    # resources :messages, only: %i[index create]
    resources :transactions, only: %i[new create show]
    resources :members, only: %i[index new create]
    resources :users, only: %i[index]
    resources :contributions, only: [:index, :show, :new, :create]
    resources :payouts, only: [:index, :show, :new, :create]
  end
  resources :members, only: %i[update]
post "stokvels/:id/accept_invite", to: "stokvels#accept_invite", as: :accept_invite
post "stokvels/:id/decline_invite", to: "members#declined", as: :decline_invite

# post '/paystack/callback', to: 'paystack#callback'
# post '/paystack/webhook', to: 'paystack#webhook'
end
