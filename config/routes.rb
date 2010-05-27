Boutique::Application.routes.draw do |map|
  get 'welcome' => 'boutique#welcome', :as => :welcome
  get 'categories' => 'boutique#category', :as => :categories

  resources :carts, :as => :cart do
    collection do
      delete :destroy_all
      put :to_order
    end
  end

  post 'autenticate' => 'user_session#create', :as => :autenticate
  get 'login' => 'user_session#new', :as => :login
  delete 'logout' => 'user_session#destroy', :as => :logout

  map.resources :deposits, :except => [ :edit, :update, :destroy ]

  get 'order/:id' => 'orders#show', :as => :order
  put 'order_action/:id' => 'orders#update', :as => :orderAction

  get 'statistics' => 'statistics#index', :as => :statistics
  get 'statistics/:stattype' => 'statistics#show', :as => :statistic

  map.resource :user
  get 'user/activate/:key' => 'users#activate', :as => :activate
  get 'user/passwordResetForm' => 'users#passwordResetForm', :as => :passwordResetForm
  post 'user/passwordReset' => 'users#passwordReset', :as => :passwordReset

  # Partie admin du site.
  namespace :admin do
    resources :guilds
    resources :users

    resources :categories
    resources :assets

    resources :orders

    resources :config_tree

    resources :deposits, :except => [:edit, :update] do
      member do
        put :validate
      end
    end

    get 'statistics' => 'statistics#index', :as => :statistics
    get 'statistics/:stattype' => 'statistics#show', :as => :statistic

    resources :jobs, :only => [:index]

    resources :logs, :only => [:index, :show]

    root :to => 'users#index', :conditions => { :method => :get }
  end

  map.root :welcome
end
