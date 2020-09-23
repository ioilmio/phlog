Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get 'users/index'
  get 'users/show'
  root to: 'opinions#index'
  resources :opinions
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i[create destroy]
end
