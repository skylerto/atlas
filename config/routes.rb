Rails.application.routes.draw do
  get 'jobs/:name/build/:number', to: 'build#show'
  get 'jobs', to: 'jobs#index'
  get 'jobs/:id', to: 'jobs#show'

  resources :jenkins
end
