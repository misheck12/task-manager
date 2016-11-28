Rails.application.routes.draw do
  root "home#index"
  
  scope "/:locale", locale: /en/ do
    root "home#index"
    resource :confirmation, only: [:show]
    resource :auth, only: [:create, :new, :destroy], :controller => :auth

    resource :dashboard, only: [:show], :controller => :dashboard

    resources :users
    get "/users/:id/edit_photo", to: 'users#edit_photo', as: 'edit_photo_user'
    patch "/users/:id/edit_photo", to: 'users#update_photo'
    get "/users/:id/edit_background", to: 'users#edit_background', as: 'edit_background_user'
    patch "/users/:id/edit_background", to: 'users#update_background'
    
    resources :clients

    resources :service_types

    resources :services
  
    resources :tasks
    delete "/tasks/:id/delete/all", to: 'tasks#destroy_all', as: 'destroy_all_tasks'
    
    end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
