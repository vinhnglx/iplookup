Rails.application.routes.draw do
  resources :ipaddresses, only: :index
end
