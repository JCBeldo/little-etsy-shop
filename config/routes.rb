Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/merchants/:id/dashboard", to: 'merchant/dashboards#show'
  
    # resources :items, only: [:index, :show]
end
