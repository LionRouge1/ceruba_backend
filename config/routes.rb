Rails.application.routes.draw do
  resources :forms do
    member do
      get 'download_csv'
      get 'download_excel'
      get 'download_json'
    end
    resources :email_templates, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :websites
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  # 
  namespace :api do
    namespace :v1 do
      post 'forms/:form_id/data_entries', to: 'data_entries#create', as: 'form_data_entries'
      # resources :data_entries, only: [:index, :create, :update, :destroy]
    end
  end
  root "forms#index"
end
