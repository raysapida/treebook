Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :activities, only: [:index]

  as :user do
    get '/register', to: 'devise/registrations#new', as: :register
    get '/login', to: 'devise/sessions#new', as: :login
    get '/logout', to: 'devise/sessions#destroy', as: :logout
  end

  devise_for :users, skip: [:sessions],
    controllers: { omniauth_callbacks: 'omniauth_callbacks',
                   registrations: 'registrations'}

  as :user do
    get "/login" => 'devise/sessions#new', as: :new_user_session
    post "/login" => 'devise/sessions#create', as: :user_session
    delete "/logout" => 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :user_friendships do
    member do
      put :accept
      put :block
    end
  end

  resources :statuses
  get 'feed', to: 'statuses#index', as: :feed

  authenticated :user do
    root :to => "statuses#index"
  end
  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'omniauth_callbacks#setup'
  end

  # root :to => 'high_voltage/pages#show', :id => 'home'

  scope ":profile_name" do
    resources :albums do
      resources :pictures
    end
  end

  namespace :blog do
    resources :articles, path: '', only: [:index, :show]
  end

  get '/:id', to: 'profiles#show', as: :profile

  get 'pages/about' => 'high_voltage/pages#show', id: 'about'
end
