Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :customers, only: %i[] do
        resources :subscriptions, only: %i[index create destroy]
      end
    end
  end
end
