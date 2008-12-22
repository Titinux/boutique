ActionController::Routing::Routes.draw do |map|
  
  map.namespace :admin do |admin|
    admin.resources :guilds
    admin.resources :users
    
    admin.resources :categories
    admin.resources :assets
    
    admin.resources :orders
  end
end
