Rails.application.routes.draw do
  root "static_pages#index"
  get "my_songs", to: "users#my_song"
  get "my_albums", to: "users#my_album"
  put 'unaccept/:id(.:format)', :to => 'admin/lyrics#unaccept', :as => :unaccept
  put 'accept/:id(.:format)', :to => 'admin/lyrics#accept', :as => :accept
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  resources :users, except: :destroy
  resources :password_resets, except: %i(index show destroy)
  resources :account_activations, only: :edit
  resources :albums
  resources :songs do
    resources :lyrics
    resources :comments
    resources :reports
  end
  namespace :admin do
    get "/", to: "dashboards#index"
    resources :categories
    resources :lyrics
  end
end
