Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/signup', to: 'users#new'
  get '/auth/ynab/callback', to: 'users#create'
  post '/signup', to: 'users#create'

  get '/signup/profile', to: 'users#edit'
  patch '/signup/profile', to: 'users#update'
  get '/signup/accounts', to: 'accounts#new'
  post '/signup/accounts', to: 'accounts#create'
end
