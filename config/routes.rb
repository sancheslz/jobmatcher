Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  
  resources :companies, only: %i[show new create edit update] do
    get 'change_state', on: :member
  end

  resources :profiles, only: %i[show new create edit update]
end
