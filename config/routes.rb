Boutique::Application.routes.draw do
  scope ':locale',
        constraints: { locale: /[a-z]{2}/ } do

    # User authentication
    devise_for :users, path: 'profile'

    # User creation
    resource :user, path: 'profile', only: [:new, :create]

    # Administrator authentication
    devise_for :administrators, path: 'admin'

    # Front page
    resource :boutique, only: [:show]

    # Categories
    resources :categories, only: [ :index, :show ]

    # Statistics
    resources :statistics, only: [ :index, :show ]

    # Cart
    resources :carts, except: [ :index, :new, :create ] do
      resources :lines, controller: 'cart_lines', only: [:edit, :update, :destroy]
    end

    resources :cart_lines, only: [ :new, :create ]

    # User profile
    resource :user, path: 'profile', except: [:new, :create] do
      resources :orders, only: [ :index, :show, :new, :create ] do
        member do
          post 'event/:event', to: 'orders#event', as: 'event'
        end
      end
      resources :deposits, only: [:index, :new, :create ]
    end

    # Partie admin du site.
    namespace :admin do
      # Administrators
      resources :administrators

      resources :guilds
      resources :users

      resources :categories
      resources :assets

      resources :orders do
        member do
          post 'event/:event', to: 'orders#event', as: 'event'
          get  'quote', to: 'orders#quote'
          patch 'quote_done', to: 'orders#quote_done'
        end
      end

      resources :config_tree

      resources :deposits, except: [:edit, :update] do
        member do
          put :validate
        end
      end

      resources :statistics, only: [ :index, :show ]

      resources :job_queues, only: [:index] do
        resources :jobs, only: [:destroy]
      end

      resources :logs, only: [:index, :show]

      get 'about', to: 'admin#about'
      root to: 'admin#show'
    end

    get 'about', to: 'boutique#about'
    root to: 'boutique#show'
  end

  get '/', to: redirect { |p, req| "/#{I18n.locale}" }
end
