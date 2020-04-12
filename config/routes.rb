Rails.application.routes.draw do
  root 'teams#index'

  resources :teams, path: '/' do
    post :pair, :rollback, on: :member

    resources :members do
      put :disable, :enable, on: :member
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
