Rails.application.routes.draw do
  resources :deployments
  resources :versions
  resources :environments
  resources :services
  get 'jobs/:name/build/:number', to: 'build#show'
  get 'jobs', to: 'jobs#index'
  get 'jobs/:id', to: 'jobs#show'

  get '/environments/:id/remove_version/:version', to: 'environments#remove_version'
  post '/environments/:id/add_service', to: 'deployments#add_service'

  resources :jenkins
end
