Rails.application.routes.draw do
  devise_for :user_regulars
  devise_for :user_adms

  root to: 'home#index'
  resources :modalities, only: [:show, :index, :new, :create, :edit, :update] do
    resources :weight_prices, only: [:index, :edit, :update, :create]
    resources :distance_prices, only: [:index, :edit, :update, :create]
    resources :deadlines, only: [:index, :edit, :update, :create]
  end

  resources :work_orders, only: [:index, :show, :new, :create] do
    resources :open_work_orders, only: [:new, :create]
    resources :close_work_orders, only: [:new, :create]
    get 'search_field', on: :collection
    get 'search', on: :collection
    get 'pending', on: :collection
  end
  

  resources :vehicles, only: [:index, :new, :create, :edit, :update] do
    get 'search', on: :collection
  end

  
 
end
