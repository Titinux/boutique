Boutique::Application.routes.draw do |map|
  scope '(:locale)', :locale => /en|fr/ do
    # User authentication
    devise_for :users, :path => 'profile', :skip => [:sessions] do
      scope :controller => 'devise/sessions', :as => :user_session do
        get  :new,     :path => 'sign_in'
        post :create,  :path => 'sign_in', :as => ""
        get  :destroy, :path => 'sign_out'
      end
    end

    # Administrator authentication
    devise_for :administrators, :path => 'admin'

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

    # Statistics
    resources :statistics, :only => [ :index, :show ]

    # User profile
    resource :user, :path => 'profile' do
      resources :orders, :only => [ :index, :show, :update ]
      resources :deposits, :only => [:index, :new, :create ]
    end

    # Partie admin du site.
    authenticate(:administrator) do
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
    end

    root :to => 'boutique#show'
  end
end
