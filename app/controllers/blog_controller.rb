class BlogsController < ApplicationController
    before_action :authenticate_user

    def index
      render json: @current_user.org.blogs
    end
end
