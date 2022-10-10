Rails.application.routes.draw do
  devise_for :user_regulars
  devise_for :user_adms

  root to: 'home#index'
  resources :modalities, only: [:show, :index, :new, :create, :edit, :update] do
    resources :weight_prices, only: [:index]
    resources :distance_prices, only: [:index]
    resources :deadlines, only: [:index]
  end

  resources :work_orders, only: [:index, :show] do
    resources :open_work_orders, only: [:new, :create]
  end
  

  resources :vehicles, only: [:index, :new, :create, :edit, :update] do
    get 'search', on: :collection
  end

  
 
end
