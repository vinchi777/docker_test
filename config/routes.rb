Rails.application.routes.draw do
  resources :tests do
    collection do
      get 'answer'
    end
    member do
      patch 'publish'
      get 'results'
      get 'students'
      post 'copy'
    end
  end

  resources :answer_sheets do
    member do
      patch 'submit'
    end
  end

  resources :grades do
    collection do
      get :new_student_grade
    end
  end

  # get 'enrollment', to: 'enrollment#index'
  # get 'enrollment/package_type', to: 'enrollment#package_type'
  resources :enrollment

  resources :student_invoices do
    member do
      post 'transaction', to: 'student_invoices#create_transaction'
      post 'transaction/destroy', to: 'student_invoices#destroy_transaction'
    end
  end

  resources :review_seasons do
    collection do
      get 'list', to: 'review_seasons#list'
    end
  end

  devise_for :users
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  resources :users do
    collection do
      get 'change_password'
      patch 'update_password'
      post 'create_student_account'
      post 'resend_confirmation'
    end
    member do
      patch 'update_user_password'
    end
  end

  resources :students do
    member do
      get 'payment'
      get 'grades_tests'
      put 'confirm'
    end
    collection do
      get :enrollment_status, :current_enrollments
    end
  end

  get 'home' => 'site#home'
  get 'about' => 'site#about'
  get 'founders' => 'site#founders'
  get 'reviewers' => 'site#reviewers'
  get 'courses' => 'site#courses'
  get 'pricing' => 'site#pricing'
  get 'our_students' => 'site#our_students'

  root 'site#home'

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
