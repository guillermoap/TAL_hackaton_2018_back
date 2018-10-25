Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      mount ActionCable.server => '/action_cable'
      resources :dealerships, only: [:index] do
        get :find, on: :collection
        get :export, on: :collection
      end
    end
  end

  match '*all', controller: 'application', action: 'cors_preflight_check', via: [:options]
end
