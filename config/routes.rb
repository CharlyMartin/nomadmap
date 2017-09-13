Rails.application.routes.draw do
  devise_for :nomads, controllers: { omniauth_callbacks: 'nomads/omniauth_callbacks' }

  root to: 'pages#home'
  get 'nomads_around', to: 'pages#nomads_around', as: 'nomads_around'
  get 'misson', to: 'pages#mission', as: 'mission'
  get 'privacy', to: 'pages#privacy', as: 'privacy'

  resources :nomads, only: %i(index show edit update)

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'nomads/:email', to: 'nomads#show', as: 'api_v1_nomad'
      post 'nomads/:email', to: 'nomads#update', , as: 'api_v1_nomad'
    end
  end

  put 'api/update'
end
