class BlogsController < ApplicationController
    def index
        @blogs = @current_user.org.blogs.order(created_at: :desc)
    end

    def show
        @blog = @current_user.org.blogs.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to blogs_path, alert: "Blog not found"
    end
end
