ActionController::Routing::Routes.draw do |map|
  # Partie publique du site.
  map.welcome    'welcome',    :controller => 'boutique', :action => 'welcome',  :conditions => { :method => :get }
  map.categories 'categories', :controller => 'boutique', :action => 'category', :conditions => { :method => :get }

  map.resources :cart, :collection => { :destroy_all => :delete, :to_order => :put }

  map.autenticate  'autenticate',  :controller => 'user_session', :action => 'create', :conditions => { :method => :post }
  map.login  'login',  :controller => 'user_session', :action => 'new', :conditions => { :method => :get }
  map.logout 'logout', :controller => 'user_session', :action => 'destroy', :conditions => { :method => :delete }

  map.resources :deposits, :except => [ :edit, :update, :destroy ]

  map.order 'order/:id', :controller => 'orders', :action => 'show', :conditions => { :method => :get }
  map.orderAction 'order_action/:id', :controller => 'orders', :action => 'update', :conditions =>{ :method => :put }

  map.statistics 'statistics', :controller => 'statistics', :action => 'index', :conditions => { :method => :get }
  map.statistic 'statistics/:stattype', :controller => 'statistics', :action => 'show', :conditions => { :method => :get }

  map.resource :user
  map.activate 'user/activate/:key', :controller => 'users', :action => 'activate', :conditions => { :method => :get }
  map.passwordResetForm 'user/passwordReset', :controller => 'users', :action => 'passwordResetForm', :conditions => { :method => :get }
  map.passwordReset 'user/passwordReset', :controller => 'users', :action => 'passwordReset', :conditions => { :method => :post }

  # Partie admin du site.
  map.namespace :admin do |admin|
    admin.resources :guilds
    admin.resources :users

    admin.resources :categories
    admin.resources :assets

    admin.resources :orders

    admin.resources :config_tree

    admin.resources :deposits, :except => [:edit, :update], :member => { :validate => :put }

    admin.resources :jobs, :only => [:index]

    admin.resources :logs, :only => [:index, :show]

    admin.root :controller => :users, :action => 'index'
  end

  # Racine du site.
  map.root :welcome
end
