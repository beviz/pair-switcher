Rails.application.routes.draw do
  root 'welcome#index'

  post :pair, to: 'welcome#pair'
  post :rollback, to: 'welcome#rollback'

  resources :members
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
