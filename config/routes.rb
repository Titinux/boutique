ActionController::Routing::Routes.draw do |map|
  
  # Partie publique du site.
  map.welcome    'welcome',    :controller => 'boutique', :action => 'welcome',  :conditions => { :method => :get }
  map.categories 'categories', :controller => 'boutique', :action => 'category', :conditions => { :method => :get }
  
  # Partie admin du site.
  map.namespace :admin do |admin|
    admin.resources :guilds
    admin.resources :users
    
    admin.resources :categories
    admin.resources :assets
    
    admin.resources :orders
    
    admin.resources :config_tree
  end
  
  # Racine du site.
  map.root :welcome
end
