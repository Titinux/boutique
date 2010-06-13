Boutique::Application.routes.draw do |map|
  scope '(:locale)' do

    # Front page
    resource :boutique, :only => [:show]

    # Categories
    resources :categories, :only => [ :index, :show ]

    # Cart
    resources :carts, :as => :cart do
      collection do
        delete :destroy_all
        put :to_order
      end
    end

    # Login system
    post 'autenticate' => 'user_session#create', :as => :autenticate
    get 'login' => 'user_session#new', :as => :login
    delete 'logout' => 'user_session#destroy', :as => :logout

    # Statistics
    resources :statistics, :only => [ :index, :show ]

    # User profile
    resource :user, :except => [ :index, :destroy ] do
      match 'password/reset', :to => :edit_password,   :via => :get,  :as => 'edit_password'
      match 'password',       :to => :update_password, :via => :post, :as => 'password'

      match 'activate/:key', :to => :activate, :via => :get, :as => 'activate'

      resources :orders, :only => [ :index, :show, :update ]
      resources :deposits, :only => [:index, :new, :create ]
    end

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

      resources :statistics, :only => [ :index, :show ]

      resources :jobs, :only => [:index]

      resources :logs, :only => [:index, :show]

      root :to => 'admin#show'
    end

    root :to => 'boutique#show'
  end
end
