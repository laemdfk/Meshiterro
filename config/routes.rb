Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
   get 'homes/about'

#  いいね・コメントをネストさせる
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
   resources :post_comments, only: [:create, :destroy]
   resource :favorite, only: [:create, :destroy]
  end
  
  # いいね機能の場合は「1人のユーザーは1つの投稿に対して1回しかいいねできない」という仕様 = idを引数として渡す必要がないのでresourcesは
  
   resources :users, only: [:show, :edit, :update]




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
