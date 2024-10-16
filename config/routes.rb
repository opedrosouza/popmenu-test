Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  resources :menus do
    resources :menu_items, only: [ :index, :show ]
  end
end
