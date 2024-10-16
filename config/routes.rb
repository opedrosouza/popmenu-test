Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :restaurants, only: [ :index, :show ], defaults: { format: :json } do
    resources :menus do
      resources :menu_items, only: [ :index, :show ]
    end
  end
end
