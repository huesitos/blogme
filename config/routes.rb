Rails.application.routes.draw do
  root 'posts#index', as: :home

  get 'posts', to: 'posts#index', as: :posts
  get 'posts/:id', to: 'posts#show', as: :post

  get 'tags/:tag', to: 'tags#show', as: :tag
  get 'authors/:nickname', to: 'authors#show', as: :author
  get 'categories/:category', to: 'categories#show', as: :category
  get 'pages/:name', to: "pages#show", as: :page

  post 'comments/:post_id', to: 'comments#create', as: :comments

  namespace "dashboard" do
    root 'posts#index', as: :dashboard

    resources :posts
    resources :pages
    resources :categories, except: [:show, :new]

    resources :authors, except: [:show] do
      patch 'update_social_links',
        to: 'authors#update_social_links',
        as: :social_links
      patch 'password',
        to: 'authors#update_password',
        as: :password
    end

    get 'tags/:id', to: 'tags#show', as: :tag
    get 'log_in', to: 'session#new', as: :log_in
    post 'log_in', to: 'session#create'
    delete 'log_out', to: 'session#destroy', as: :log_out
    delete 'comment/:id', to: 'comments#destroy', as: :comment
  end
end
