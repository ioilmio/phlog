Rails.application.routes.draw do
  root to: 'opinions#index'
  resources :opinions
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i[create destroy]
end
