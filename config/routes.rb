Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'bookings', to: 'pages#bookings'

  resources :flats do
    resources :bookings, only: [:create, :new]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :bookings, only: [:destroy] do
    member do
      post 'update_status', to: 'bookings#update_status'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
