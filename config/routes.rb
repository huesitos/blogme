Rails.application.routes.draw do
  get 'posts', to: 'posts#index', as: :posts
end
