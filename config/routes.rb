Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  devise_for :users
  resources :cocktails, only: [:index, :show, :new, :create, :edit, :destroy] do

    resources :doses, only: [:new, :create]
  end

  post 'cocktails/:id/upvote', to: "cocktails#upvote"
  # POST /cocktails/:id/upvote

  resources :doses, only: :destroy
end
