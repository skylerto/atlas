Rails.application.routes.draw do
  get 'jobs', to: 'jobs#index'
  get 'jobs/:id', to: 'jobs#show'

  resources :jenkins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
