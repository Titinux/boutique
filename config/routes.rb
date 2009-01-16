ActionController::Routing::Routes.draw do |map|
  
  # Partie publique du site.
  map.welcome    'welcome',    :controller => 'boutique', :action => 'welcome',  :conditions => { :method => :get }
  map.categories 'categories', :controller => 'boutique', :action => 'category', :conditions => { :method => :get }
  
  map.resources :cart, :collection => { :destroy_all => :delete }
  
  # Partie admin du site.
  map.namespace :admin do |admin|
    admin.resources :guilds
    admin.resources :users
    
    admin.resources :categories
    admin.resources :assets
    
    admin.resources :orders
    
    admin.resources :config_tree
    
    admin.root :controller => :users, :action => 'index'
  end
  
  # Racine du site.
  map.root :welcome
end
