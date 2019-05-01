Rails.application.routes.draw do
  resources :competitions, only: [ :index, :show, :create, :update, :destroy ], defaults: { format: :json } do
    patch 'finish', on: :member
    put 'finish', on: :member
  end
end
