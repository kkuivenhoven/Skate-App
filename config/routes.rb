#Sources:
#https://www.railstutorial.org/book, Hartl Michael, 2014

Rails.application.routes.draw do
# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

# You can have the root of your site routed with "root"
# root 'welcome#index'
  root 'static_pages#home'

	get '/google0d522795c8df8607.html',
		to: proc { |env| [200, {}, ["google-site-verification: google0d522795c8df8607.html"]] }

  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/skate_links'
  get 'static_pages/testing'

  get 'users/unblock_user', to: 'users#unblock_user'
  get 'users/block_user', to: 'users#block_user'
  get 'skate_spots/recommender'
  get 'skate_spots/search_results'
  get 'skate_spots/show'
  get 'skate_spots/test_page', to: 'skate_spots#test_page', as: 'test_page'
  get 'skate_spots/new_by_geo', to: 'skate_spots#new_by_geo', as: 'new_by_geo'
  post 'skate_spots/create_by_geo', to: 'skate_spots#create_by_geo', as: 'create_by_geo'
  get 'skate_spots/like_ss'
  get 'skate_spots/dislike_ss'

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'password_resets/index'

  get 'users/search_results'

  resources :skate_spots do
    resources :ratings, :except => :index
    resources :events, :except => :index
	  # get 'ratings/reply/:id', to: 'ratings#reply'
	  # post 'ratings/:id', to: 'ratings#reply', as: 'rating_responses'
  end
	post 'ratings/:id', to: 'ratings#reply', as: 'rating_responses'
  delete 'ratings/:id', to: 'ratings#delete_reply', as: 'rating_delete_reply'
  get 'ratings/index', to: 'ratings#index', as: 'ratings'

  get 'events/index', to: 'events#index', as: 'events'

  get 'signup' => 'users#new'

  get 'login' => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers, :blocked
    end
  end

	get 'microposts/news_feed' => 'microposts#news_feed'

  resources :users, 			  only: [:show, :index, :new, :create, :edit, :update, :destroy, :search_results]
  resources :account_activations, only: [:edit] #named route for edit action
  resources :password_resets,     only: [:new, :create, :edit, :update, :index]
	resources :microposts,          only: [:create, :destroy]
	resources :relationships,       only: [:create, :destroy]
  delete 'blockUser'  => 'relationships#blockUser'

end
