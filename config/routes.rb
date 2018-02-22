Rails.application.routes.draw do
  resource :dashboard, only: [:show]

  root 'resource_items#index'

  
  resources :lens_shifter_profiles
  resources :profiles
  
  resources :resource_items, only: [:index, :show]
  resources :streams, only: [:index, :show]
  resources :guides, only: [:index]

  namespace :fellow do
    resources :resource_items do
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
  end

  devise_for :lens_shifters, controllers: {
    registrations: "lens_shifters/registrations"
  }
  

  get 'details', to: 'static_pages#details'

  resources :static_pages, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
