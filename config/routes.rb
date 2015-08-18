Rails.application.routes.draw do
  get 'posts', to: 'posts#index', as: :posts
  get 'posts/:id', to: 'posts#show', as: :post

  get 'tags/:id', to: 'tags#show', as: :tag
end
