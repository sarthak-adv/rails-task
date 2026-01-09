class LoginController < ApplicationController
    skip_before_action :authenticate_user, only: [ :new, :check_access, :logout ]

    skip_forgery_protection only: [ :check_access ]

    def new
        redirect_to blogs_path if session[:user_id].present?
    end

    def check_access
        email = params[:email]
        password = params[:password]

        user = User.find_by(email: email)

        if user&.authenticate(password)
            # Set session for authentication
            session[:user_id] = user.id
            # get all blogs
            blogs = user.org.blogs

        render json: {
            blog_data: blogs,
            success: true,
            user_id: user.id,
            message: "Login successful"
        }, status: :ok
        else
        render json: {
            success: false,
            error: "Invalid email or password"
        }, status: :unauthorized
        end
    end

    def logout
        session[:user_id] = nil
        redirect_to login_path, notice: "Logged out successfully"
    end
end
