Rails.application.routes.draw do
  root "home#index"
  
  scope "/:locale", locale: /en/ do
    root "home#index"
    resource :confirmation, only: [:show]
    resource :auth, only: [:create, :new, :destroy], :controller => :auth

    resource :dashboard, only: [:show], :controller => :dashboard, as: 'dashboard'

    resources :users
    get "/users/:id/edit/photo", to: 'users#edit_photo', as: 'edit_photo_user'
    patch "/users/:id/edit/photo", to: 'users#update_photo'
    get "/users/:id/edit/background", to: 'users#edit_background', as: 'edit_background_user'
    patch "/users/:id/edit/background", to: 'users#update_background'
    get "/users/:id/edit/profile", to: 'users#edit_profile', as: 'edit_profile_user'
    patch "/users/:id/edit/profile", to: 'users#update_profile'
    get "/users/:id/edit/password", to: 'users#edit_password', as: 'edit_password_user'
    patch "/users/:id/edit/password", to: 'users#update_password'
    
    resources :clients

    resources :service_types

    resources :services
  
    resources :tasks
    delete "/tasks/:id/delete/all", to: 'tasks#destroy_all', as: 'destroy_all_tasks'

    get "/settings/roles", to: 'settings#roles', as: 'settings_roles'
    post "/settings/roles", to: 'settings#update_roles', as: 'edit_settings_roles'
    
    end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
