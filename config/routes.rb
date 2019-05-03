Rails.application.routes.draw do
  resources :competitions, only: [ :index, :show, :create, :update, :destroy ], defaults: { format: :json } do
    patch 'finish', on: :member
  end

  resources :results, only: [ :index, :show, :create, :destroy ], defaults: { format: :json }
end
