class BlogsController < ApplicationController
    before_action :ensure_admin, only: [ :edit, :update, :delete_blog ]
    before_action :set_blog, only: [ :show, :edit, :update, :delete_blog ]

    def index
        @blogs = @current_user.org.blogs.order(created_at: :desc)
    end

    def show
    rescue ActiveRecord::RecordNotFound
        redirect_to blogs_path, alert: "Blog not found"
    end

    def edit
    end

    def update
        if @blog.update(blog_params)
            redirect_to blog_path(@blog), notice: "Blog updated successfully"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def patch_blog
        @blog = @current_user.org.blogs.find(params[:id])

        if @blog.update(blog_params)
          render json: { message: "Blog updated", blog: @blog }
        else
          render json: { errors: @blog.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def delete_blog
      if @blog.destroy
        redirect_to blogs_path, notice: "Blog deleted successfully"
      else
        redirect_to blog_path(@blog), alert: "Failed to delete blog"
      end
    end

    private

    def set_blog
        @blog = @current_user.org.blogs.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to blogs_path, alert: "Blog not found"
    end

    def ensure_admin
        unless @current_user&.role == 1
            redirect_to blogs_path, alert: "You don't have permission to perform this action"
        end
    end

    def blog_params
        params.require(:blog).permit(:title, :body)
    end
end
