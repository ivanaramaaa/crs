Rails.application.routes.draw do
  
  get 'coupons/generate_coupon_code'
  get 'coupons/check_coupon_code'
  post 'check_coupon_code' => 'coupons#check_coupon_code'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resources :users do
  resources :credit_cards
  end

  resources :users do
  resources :papers
  end
  resources :papers
  resources :receipts
  resources :conferences
  resources :conference_registrations
  resources :event_registrations
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  get 'select-conference' => 'conference_registrations#select_conference'
  get 'select-events' => 'conference_registrations#select_events'
  get 'registration_summary' => 'conference_registrations#registration_summary'
  post 'registration_summary' => 'conference_registrations#get_discount'
  post 'registration/final' => 'conference_registrations#final'

  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'credit_cards/index'
  get 'credit_cards/new'
  get 'credit_cards/create'
  get 'credit_cards/edit'
  get 'credit_cards/update'
  get 'credit_cards/show'
  get 'credit_cards/destroy'
  get 'conferences/new'
  get 'conferences/create'
  get 'conferences/edit'
  get 'conferences/update'
  get 'conferences/destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
