Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:create] do
        collection do
          get :top
          get :ip_list
        end
        member do
          resources :reviews, only: [:create]
        end
      end
    end
  end
end
