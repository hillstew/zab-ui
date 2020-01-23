Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index', as: 'welcome'
  get '/auth/ynab/callback', to: 'ynab#create'
  post '/signup', to: 'users#create'
  delete 'logout', to: 'sessions#destroy'

  get '/signup/ynab', to: 'ynab#new'
  get '/accounts/update', to: 'accounts#update', as: 'accounts_update'
  patch '/signup/profile', to: 'users#update'
  get '/signup/accounts', to: 'accounts#new'
  post '/signup/accounts', to: 'accounts#create'
  get '/dashboard', to: 'dashboard#index'
  get '/snowball/:amount', to: 'dashboard/snowball#index'

  get '/auth/google_oauth2/callback', to: 'users#create'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
