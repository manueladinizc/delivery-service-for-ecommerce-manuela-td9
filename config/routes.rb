Rails.application.routes.draw do
  devise_for :user_regulars
  devise_for :user_adms

  root to: 'home#index'
  resources :modalities, only: [:index, :new, :create, :edit, :update]
  resources :vehicles, only: [:index, :new, :create, :edit, :update] do
    get 'search', on: :collection
  end

 
end
