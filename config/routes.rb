Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "blogs#index"

  # Login routes
  get "/login", to: "login#new", as: :login
  post "/login", to: "login#check_access", as: :user_login
  get "/logout", to: "login#logout", as: :logout

  # Blogs
  get "/blogs",     to: "blogs#index", as: :blogs
  get "/blogs/:id", to: "blogs#show",  as: :blog

  patch  "/blog/:id", to: "blogs#patch_blog",  as: :patch_blog
  delete "/blog/:id", to: "blogs#delete_blog", as: :delete_blog
end
