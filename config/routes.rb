Rails.application.routes.draw do
  root to: 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts, only: %i[index show new create] do
    resources :comments, only: :create
  end
end
