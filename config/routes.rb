Rails.application.routes.draw do
  resource :dashboard, only: [:show]

  root 'static_pages#landing'

  resources :profiles, except: [:index]
  resources :resource_items, path: 'library', only: [:index, :show]
  resources :streams, only: [:index, :show]
  resources :guides, only: [:index]

  get '/landing', to: "static_pages#landing", as: :landing
  get '/home', to: "static_pages#home", as: :home


  namespace :fellow do
    resources :resource_items do
        get :get_article
      collection do
        get :import_google
        get 'doc/:file_id', to: 'resource_items#doc', as: :doc
        get :export_csv
        post :import_csv
      end
    end

    resources :guides, except: [:show]
    resources :streams do
      resources :lessons, only: [:new, :create, :update, :destroy]
    end
    resources :lessons, only: [:new, :create, :update, :destroy]
    resources :static_pages, except: [:show]
  end

  devise_for :lens_shifters, controllers: {
    registrations: "lens_shifters/registrations"
  }

  resources :static_pages, path: '/', only: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
