Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  
  resources :companies, only: %i[index show new create edit update] do
    get 'change_state', on: :member
  end

  resources :profiles, only: %i[show new create edit update]

  resources :technologies, only: %i[index new create edit update]

  resources :opportunities, only: %i[index show new create edit update] do
    get 'change_visibility', on: :member
    get 'application_list', on: :member
    get 'application_detail', on: :member
  end

  resources :submissions, only: %i[index new create destroy] do 
    get 'remove', on: :member
  end
  
end
