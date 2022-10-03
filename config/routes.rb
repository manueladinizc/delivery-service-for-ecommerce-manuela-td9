Rails.application.routes.draw do
  devise_for :user_adms
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'
  resources :modalities, only: [:index, :new, :create, :edit, :update]
end
