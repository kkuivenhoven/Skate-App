#Sources:
#https://www.railstutorial.org/book, Hartl Michael, 2014

Rails.application.routes.draw do
# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

# You can have the root of your site routed with "root"
# root 'welcome#index'
  root 'static_pages#home'

  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/skate_links'
  get 'static_pages/testing'
  get 'skate_spots/search_results'
  get 'skate_spots/show'
  get 'skate_spots/test_page', to: 'skate_spots#test_page', as: 'test_page'
  get 'skate_spots/new_by_geo', to: 'skate_spots#new_by_geo', as: 'new_by_geo'
  post 'skate_spots/create_by_geo', to: 'skate_spots#create_by_geo', as: 'create_by_geo'
  get 'skate_spots/street_spots_index'
  get 'skate_spots/park_spots_index'
  get 'skate_spots/like_ss'
  get 'skate_spots/dislike_ss'

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'password_resets/index'

  get 'users/search_results'

  resources :skate_spots do
    resources :ratings, :except => :index
    resources :events, :except => :index
  end
  get 'ratings/index', to: 'ratings#index', as: 'ratings'
  get 'ratings/testing_this', to: 'ratings#testing_this', as: 'testing_this'
  get 'ratings/index_park_spot'
  get 'ratings/index_street_spot'

  get 'events/index', to: 'events#index', as: 'events'

  get 'signup' => 'users#new'

  get 'login' => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end

	get 'microposts/news_feed' => 'microposts#news_feed'

  resources :users, 			  only: [:show, :index, :new, :create, :edit, :update, :destroy, :search_results]
  resources :account_activations, only: [:edit] #named route for edit action
  resources :password_resets,     only: [:new, :create, :edit, :update, :index]
	resources :microposts,          only: [:create, :destroy]
	resources :relationships,       only: [:create, :destroy]

end
