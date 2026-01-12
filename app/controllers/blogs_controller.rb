class BlogsController < ApplicationController
    def index
        @blogs = @current_user.org.blogs.order(created_at: :desc)
    end

    def show
        @blog = @current_user.org.blogs.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to blogs_path, alert: "Blog not found"
    end

    def patch_blog
        @blog = @current_user.org.blogs.find(params[:id])

        if @blog.update(blog_params)
          render json: { message: "Blog updated", blog: @blog }
        else
          render json: { errors: @blog.errors.full_messages }, status: :unprocessable_entity
        end

    def delete_blog
      @blog = @current_user.org.blogs.find(params[:id])

      if @blog.delete(blog_params)
        render json: { message: "Blog deleted", blog: @blog }
      else
        render json: { errors: @blog.errors.full_message }, status: :unprocessable_entity
      end
    end
end
end
