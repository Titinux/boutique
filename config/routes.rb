Boutique::Application.routes.draw do
  scope ':locale',
        :constraints => { :locale => /[a-z]{2}/ } do

    # User authentication
    devise_for :users, :path => 'profile'

    # User creation
    resource :user, :path => 'profile', :only => [:new, :create]

    # Administrator authentication
    devise_for :administrators, :path => 'admin'

    # Front page
    resource :boutique, :only => [:show]

    # Categories
    resources :categories, :only => [ :index, :show ]

    # Statistics
    resources :statistics, :only => [ :index, :show ]

    # Cart
    resource :cart, :controller => 'cart', :except => [ :index, :new ] do
      get :to_order
      get :save

      resources :lines, :controller => 'cart_lines', :except => [ :index, :show ]
    end

    # User profile
    resource :user, :path => 'profile', :except => [:new, :create] do
      resources :orders, :only => [ :index, :show, :update ]
      resources :deposits, :only => [:index, :new, :create ]
      resources :carts do
        member do
          get :use_it
          get :to_order
        end
      end
    end

    # Partie admin du site.
    namespace :admin do
      # Administrators
      resources :administrators

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

  match '/', :to => redirect(proc { "/#{I18n.locale}" })
end
