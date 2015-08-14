Rails.application.routes.draw do
  root 'posts#index', as: :home

  get 'posts', to: 'posts#index', as: :posts
  get 'posts/:id', to: 'posts#show', as: :post

  get 'tags/:tag', to: 'tags#show', as: :tag
  get 'authors/:nickname', to: 'authors#show', as: :author

  namespace "dashboard" do
    root 'posts#index', as: :dashboard

    resources :posts
    resources :authors, except: [:show]
    get 'tags/:id', to: 'tags#show', as: :tag
    get 'log_in', to: 'session#new', as: :log_in
    post 'log_in', to: 'session#create'
    delete 'log_out', to: 'session#destroy', as: :log_out
  end
end
