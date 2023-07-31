Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :customers, only: %i[] do
        resources :subscriptions, only: %i[create]
      end
    end
  end
end
