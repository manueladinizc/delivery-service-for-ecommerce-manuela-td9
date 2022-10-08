Rails.application.routes.draw do
  devise_for :user_regulars
  devise_for :user_adms

  root to: 'home#index'
  resources :modalities, only: [:show, :index, :new, :create, :edit, :update] do
    resources :weight_prices, only: [:index]
  end


  resources :vehicles, only: [:index, :new, :create, :edit, :update] do
    get 'search', on: :collection
  end

  
 
end
