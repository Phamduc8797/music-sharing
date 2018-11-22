Rails.application.routes.draw do
  root "static_pages#index"
  get "my_songs", to: "users#my_song"
  get "my_albums", to: "users#my_album"
  post "add_to_albums", to: "songs#update"
  put 'unaccept/:id(.:format)', :to => 'admin/lyrics#unaccept', :as => :unaccept
  put 'accept/:id(.:format)', :to => 'admin/lyrics#accept', :as => :accept
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "/songs/search", to: "songs#search", as: "search_path"
  get "/songs/filter", to: "songs#filter"
  get "songs/recommend", to: "songs#recommend_song"
  get "songs/chart", to: "songs#chart_songs"
  resources :users, except: :destroy
  resources :password_resets, except: %i(index show destroy)
  resources :account_activations, only: :edit
  resources :albums
  resources :songs do
    resources :lyrics
    resources :comments
    resources :reports
  end
  resources :videos
  resources :likes
  namespace :admin do
    get "/", to: "dashboards#index"
    resources :categories
    resources :singers
    resources :authors
    resources :users, except: %i(new create)
    resources :lyrics
    resources :reports
    resources :comments
    resources :songs
  end
end
