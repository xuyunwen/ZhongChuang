Rails.application.routes.draw do
  get 'users/index'

  get 'users/new'

  get 'users/show'

  get 'users/create'

  get 'users/destroy'

  get 'users/update'

  get 'users/edit'

  get 'chapter_votes/create'

  get 'chapter_votes/destory'

  get 'chapter_votes/update'

  get 'chapter_comments/create'

  get 'chapter_comments/destory'

  get 'chapter_comments/update'

  get 'novel_comments/create'

  get 'novel_comments/destory'

  get 'novel_comments/update'

  get 'roles/index'

  get 'roles/new'

  get 'roles/show'

  get 'roles/create'

  get 'roles/destory'

  get 'roles/update'

  get 'roles/edit'

  get 'chapters/index'

  get 'chapters/new'

  get 'chapters/show'

  get 'chapters/create'

  get 'chapters/destory'

  get 'chapters/update'

  get 'chapters/edit'

  get 'categorys/index'

  get 'categorys/new'

  get 'categorys/show'

  get 'categorys/create'

  get 'categorys/destory'

  get 'categorys/update'

  get 'categorys/edit'

  get 'novels/index'

  get 'novels/new'

  get 'novels/show'

  get 'novels/create'

  get 'novels/destory'

  get 'novels/update'

  get 'novels/edit'

  get 'user_group_own_permissions/create'

  get 'user_group_own_permissions/destory'

  get 'user_group_own_permissions/update'

  get 'permissions/index'

  get 'permissions/new'

  get 'permissions/show'

  get 'permissions/create'

  get 'permissions/destory'

  get 'permissions/update'

  get 'permissions/edit'

  get 'user_groups/index'

  get 'user_groups/new'

  get 'user_groups/show'

  get 'user_groups/create'

  get 'user_groups/destory'

  get 'user_groups/update'

  get 'user_groups/edit'

  get 'users/index'

  get 'users/new'

  get 'users/show'

  get 'users/create'

  get 'users/destroy'

  get 'users/update'

  get 'users/edit'

  root 'static_pages#home'

  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users

  resources :user_groups



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
