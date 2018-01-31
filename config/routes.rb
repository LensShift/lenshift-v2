Rails.application.routes.draw do
  resource :dashboard, only: [:show]

  root 'resource_items#index'

  resources :resource_items, only: [:index, :show]
  resources :lens_shifter_profiles
  resources :profiles
  namespace :fellow do
    resources :resource_items do
      collection do
        get :import_google
        get 'doc/:file_id', to: 'resource_items#doc', as: :doc
        get :export_csv
        post :import_csv
      end
    end
  end

  devise_for :lens_shifters, controllers: {
    registrations: "lens_shifters/registrations"
  }
  

  get 'details', to: 'static_pages#details'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
