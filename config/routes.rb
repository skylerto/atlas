Rails.application.routes.draw do
  resources :deployments
  resources :versions
  resources :environments
  resources :services
  get 'jobs/:name/build/:number', to: 'build#show'
  get 'jobs', to: 'jobs#index'
  get 'jobs/:id', to: 'jobs#show'

  resources :jenkins
end
