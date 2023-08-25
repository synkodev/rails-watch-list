Rails.application.routes.draw do
  get 'reviews/create'
  get 'bookmarks/new'
  get 'lists/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :lists, only: %i[index show new create] do
    # No 'new' action since the form will be in lists#show view
    resources :bookmarks, only: :create
    # Add route to create review
    resources :reviews, only: :create
  end

  delete 'bookmarks/:id', to: 'bookmarks#destroy', as: :bookmark
end
