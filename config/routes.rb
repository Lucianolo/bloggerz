Rails.application.routes.draw do

 
  
  put '/books/:id/like', to: 'books#like', as: :like_book
  put '/books/:id/dislike', to: 'books#dislike', as: :dislike_book
  
  put '/books/:id/unlike', to: 'books#unlike', as: :unlike_book
  put '/books/:id/undislike', to: 'books#undislike', as: :undislike_book  
  

  resources :books do
    resources :comments 
  end

  
  
  
  get 'friends', to: 'user_friendships#show', as: :friendships
  
  get 'friends/accept/:id', to: 'user_friendships#accept', as: :accept_friendship
  
  get 'friends/decline/:id', to: 'user_friendships#decline', as: :decline_friendship
  
  get 'search-results/:id', to: 'profiles#index', as: :search
 
  devise_for :users, :controllers => { registrations: 'registrations' , omniauth_callbacks: 'callbacks', sessions: 'custom_sessions'}
  
  
  
  #Custom Routes , adding /register and /login .
  devise_scope :user do
    get 'register', to: 'devise/registrations#new', as: :register
    get 'login', to: 'devise/sessions#new', as: :login
    get 'logout', to: 'devise/sessions#destroy', as: :logout
  end
  
  resources :statuses
  
  get 'feed', to: 'statuses#index', as: :feed
  root to: 'books#index'
  
  get 'notification', to: 'notifications#index'
  
  get '/:id', to: 'profiles#show', as: 'profile'
  
  
  
  resources :user_friendships
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
