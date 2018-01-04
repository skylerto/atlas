Rails.application.routes.draw do
  resources :deployments
  post '/deployments/add_service/:id', to: 'deployments#add_service'
  post '/deployments/update_service/:id', to: 'deployments#update_service'
  post '/deployments/remove_service/:id', to: 'deployments#remove_service'

  resources :versions
  post '/services/add_version/:id', to: 'services#add_version'

  resources :environments
  get '/environments/:id/remove_version/:version', to: 'environments#remove_version'

  resources :services
  post 'services/load_versions/:id', to: 'services#load_versions'

  get 'jobs/:name/build/:number', to: 'build#show'
  get 'jobs', to: 'jobs#index'
  get 'jobs/:id', to: 'jobs#show'

  resources :jenkins
end
