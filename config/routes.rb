Rails.application.routes.draw do
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'about' => 'static_pages#about'
  get 'random' => 'static_pages#random'


  # Defines the root path route ("/")
  # root "articles#index"
  root "ideas#index"

  resources :ideas
end
