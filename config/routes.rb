Sky::Application.routes.draw do
  get '/' => 'home#index', :as => :home
  post '/' => 'home#create'
  get '/user/:id' => "home#user"

  get '/login' => 'home#login'
  get '/logout' => 'home#logout'
  
  get '/msg_data' => 'home#msg_data'
  get '/index/reload' => 'home#reload'
<<<<<<< HEAD
=======
  get '/index/friendinfo' => 'home#friendinfo'
  get '/index/titleinfo' => 'home#titleinfo'

  get '/msg/:msg_id' => 'home#msg'
  get '/deleteMsg/:msg_id' => 'home#deleteMsg'
>>>>>>> be36e74b3bef665d0c329161b7e82cde4d9f327b

  get '/like/:msg_id' => 'home#like'
  get '/lol/:msg_id' => 'home#lol'

<<<<<<< HEAD
  get '/msg/:msg_id' =>'home#msg'

  get '/commentCreat' => 'home#add'
  post '/commentCreat' => 'home#commentCreat'

   get '/CommentLike/:comment_id' => 'home#CommentLike'
   get '/deleteComment/:comment_id' => 'home#deleteComment'
=======
  get '/commentCreat' => 'home#add'
  post '/commentCreat' => 'home#commentCreat'

  get '/deleteComment/:comment_id' => 'home#deleteComment'
>>>>>>> be36e74b3bef665d0c329161b7e82cde4d9f327b

  get '/add' => 'home#add'
  post '/add' => 'home#create' 

<<<<<<< HEAD
=======

get '/addtest' => 'home#_addPost'

>>>>>>> be36e74b3bef665d0c329161b7e82cde4d9f327b
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
