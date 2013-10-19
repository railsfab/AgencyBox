AgencyBox::Application.routes.draw do
  devise_for :users
  root to: "home#index"

  get "expense/new"
  get "expense/index"
  get "expense/:id" => "expense#show", as: :expense_show
  post "expense/create"
 
  get "expense/category/index" => "expense_category#index"
  get "expense/category/new" => "expense_category#new"
  post "expense/category/create" => "expense_category#create"
  get "expense/category/:slug" => "expense_category#show", as: "expense_category_show"

  get "admin/expense/edit/:id" => "expense_admin#edit", as: "expense_admin_edit"
  post "admin/expense/modify/:id" => "expense_admin#modify", as: "expense_admin_modify"

  get "admin/expense/category/edit/:id" => "expense_category#edit", as: "expense_category_admin_edit"
  patch "admin/expense/category/modify/:id" => "expense_category#modify", as: "expense_category_admin_modify"

  get "admin/leave/category/new" => "leave_category#new", as: "leave_category_new"
  get "admin/leave/category/edit/:id" => "leave_category#edit", as: "leave_category_edit"
  post "admin/leave/category/create" => "leave_category#create", as: "leave_category_create"
  patch "admin/leave/category/modify/:id" => "leave_category#modify", as: "leave_category_modify"
  get "leave/category/index" => "leave_category#index", as: "leave_category_index"
  get "leave/category/:id" => "leave_category#show", as: "leave_category_show"

  get "leave/new"
  #get "leave/edit/:id"
  post "leave/create"
  #patch "leave/modify"
  get "leave/index"
  get "leave/show/:id" => "leave#show", as: "leave_show"

  get "admin/leave/edit/:id" => "leave_admin#edit", as: "admin_leave_edit"
  post "admin/leave/modify/:id" => "leave_admin#modify", as: "admin_leave_modify"

  get "user/index" => "user#index", as: "user_index"
  get "user/:id" => "user#show", as: "user_show"


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
