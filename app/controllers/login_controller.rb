class LoginController < ApplicationController
    # skip csrf token check
    skip_before_action :verify_authenticity_token
    def check_access
        email = params[:email]
        password = params[:password]

        user = User.find_by(email: email)

        if user&.authenticate(password)
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
end
