Boutique::Application.routes.draw do |map|
  match 'welcome' => 'boutique#welcome', :as => :welcome, :conditions => { :method => :get }
  match 'categories' => 'boutique#category', :as => :categories, :conditions => { :method => :get }

  resources :carts, :as => :cart do
    collection do
      delete :destroy_all
      put :to_order
    end
  end

  match 'autenticate' => 'user_session#create', :as => :autenticate, :conditions => { :method => :post }
  match 'login' => 'user_session#new', :as => :login, :conditions => { :method => :get }
  match 'logout' => 'user_session#destroy', :as => :logout, :conditions => { :method => :delete }

  map.resources :deposits, :except => [ :edit, :update, :destroy ]

  match 'order/:id' => 'orders#show', :as => :order, :conditions => { :method => :get }
  match 'order_action/:id' => 'orders#update', :as => :orderAction, :conditions =>{ :method => :put }

  match 'statistics' => 'statistics#index', :as => :statistics, :conditions => { :method => :get }
  match 'statistics/:stattype' => 'statistics#show', :as => :statistic, :conditions => { :method => :get }

  map.resource :user
  match 'user/activate/:key' => 'users#activate', :as => :activate, :conditions => { :method => :get }
  match 'user/passwordResetForm' => 'users#passwordResetForm', :as => :passwordResetForm, :conditions => { :method => :get }
  match 'user/passwordReset' => 'users#passwordReset', :as => :passwordReset, :conditions => { :method => :post }

  # Partie admin du site.
  namespace :admin do
    resources :guilds
    resources :users

    resources :categories
    resources :assets

    resources :orders

    resources :config_tree

    resources :deposits, :except => [:edit, :update], :member => { :validate => :put }

    match 'statistics' => 'admin/statistics#index', :as => :statistics, :conditions => { :method => :get }
    match 'statistics/:stattype' => 'admin/statistics#show', :as => :statistic, :conditions => { :method => :get }

    resources :jobs, :only => [:index]

    resources :logs, :only => [:index, :show]

    root :to => 'admin/users#index', :conditions => { :method => :get }
  end

  map.root :welcome
end
