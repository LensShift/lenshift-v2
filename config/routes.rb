Rails.application.routes.draw do

  resources :team_members, only: [:index]

  resource :dashboard, only: [:show]

  root 'static_pages#home'

  devise_scope :lens_shifter do
    root 'resources_items#index', as: :lens_shifter_root
  end

  resources :blogs, only: [:index, :show]

  resources :profiles, except: [:index]
  resources :resource_items, path: 'library', only: [:index, :show]
  resources :streams, only: [:index, :show] do
    resources :lessons, only: [:show]
    get '/preview', to: 'stream#preview', as: :preview
  end
  resources :guides, only: [:index]

  get '/landing', to: "static_pages#landing", as: :landing
  get '/home', to: "static_pages#home", as: :home
  get '/contact', to: "static_pages#contact", as: :contact

  namespace :fellow do
    resources :lens_shifters, only: [:index, :show] do
      collection do
        get :export_csv
        get :export_profile_csv
      end
    end

    resources :team_members
    resources :resource_items do
        get :get_article
      collection do
        get :import_google
        get 'doc/:file_id', to: 'resource_items#doc', as: :doc
        get :export_csv
        post :import_csv
      end
    end
    resources :documents, except: [:show]
    resources :photos, except: [:show]
    resources :blogs, except: [:show]
    resources :guides, except: [:show]
    resources :streams do
      resources :lessons, only: [:new, :create, :update, :destroy]
    end
    resources :lessons, only: [:new, :create, :update, :destroy]
    resources :static_pages, except: [:show]
  end

  devise_for :lens_shifters, controllers: {
    registrations: "lens_shifters/registrations",
    sessions: "lens_shifters/sessions"
  }

  resources :static_pages, path: '/', only: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
