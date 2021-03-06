AgencyBox::Application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :expenses
  
  namespace :expense do
    resources :categories, :only => [:new]
    get "categories/:slug" => "categories#show", as: "category"
    resources :categories, :except => [:show, :new]
  end

  namespace :leave do
    resources :categories
  end

  resources :leaves

  resources :users, only: [:index, :show]
  get "profile/edit" => "users#edit", as: "edit_user"
  patch "users/:id" => "users#update", as: "update_user"

  get "message/:id/new" => "message#new", as: :message_new
  post "message/:id/create" => "message#create", as: :message_create
  get "message/inbox" => "message#inbox", as: "message_inbox"
  get "message/sent" => "message#sent", as: "message_sent"

  get "message/:id/reply" => "message#new_reply", as: :message_reply_new
  post "message/:id/reply" => "message#send_reply", as: :message_send_reply
  get "message/:id/" => "message#show", as: :message_show

  resources :projects, :except => [:show, :edit]
  get "projects/:slug" => "projects#show", as: "project_show"
  get "projects/:slug/edit" => "projects#edit", as: "edit_project"
  patch "projects/:slug/update" => "projects#update"

  get "projects/:slug/members/add" => "project_members#new", as: "add_project_members"
  post "projects/:slug/members/add" => "project_members#create"
  
  get "tickets/" => "tickets#index"
  #get "project/:project_slug/tickets/new" => "tickets#new", as: :new_ticket
  #get "project/:project_slug/tickets/" => "tickets#tickets", as: :project_tickets
  #get "project/:project_slug/tickets/:id" => "tickets#show", as: :ticket
  #get "project/:project_slug/tickets/:id/edit" => "tickets#edit", as: :edit_ticket
  #post "project/:project_id/tickets" => "tickets#create"
  #patch "project/:project_slug/tickets/:id/edit" => "tickets#update"
  namespace :project do 
    get ":namespace_slug/tickets/new" => "tickets#new", as: :new_ticket
    get ":namespace_slug/tickets/" => "tickets#index", as: :tickets
    get ":namespace_slug/tickets/:id" => "tickets#show", as: :ticket
    get ":namespace_slug/tickets/:id/edit" => "tickets#edit", as: :edit_ticket
    post ":namespace_id/tickets" => "tickets#create"
    patch ":namespace_slug/tickets/:id/edit" => "tickets#update"
  end

  post "ticket/:ticket_id/ticket_comment/create" => "ticket_comment#create", as: :ticketcomment_create

  resources :leads do
      collection do
          delete :delete_multiple
      end
  end
  get "leads/dashboard"
  post "leads/convert", as: :convert_lead
 
  namespace :lead do
      resources :sources do
          collection do
              delete :delete_multiple
          end
      end
  end



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
