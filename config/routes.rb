Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "blogs#index"

  # Login routes
  get "/login", to: "login#new", as: :login
  post "/login", to: "login#check_access", as: :user_login
  get "/logout", to: "login#logout", as: :logout

  # Blogs
  get "/blogs",     to: "blogs#index", as: :blogs
  get "/blogs/:id", to: "blogs#show",  as: :blog

  patch  "/blogs/:id", to: "blogs#patch_blog",  as: :patch_blog
  delete "/blogs/:id", to: "blogs#delete_blog", as: :delete_blog
end
