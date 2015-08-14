Rails.application.routes.draw do
  root 'posts#index', as: :home

  get 'posts', to: 'posts#index', as: :posts
  get 'posts/:id', to: 'posts#show', as: :post

  get 'tags/:id', to: 'tags#show', as: :tag

  namespace "dashboard" do
    resources :posts
    resources :tags, only: [:show]
    resources :authors
  end
end
