class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  protect_from_forgery with: :exception

  before_action :authenticate_user

  def authenticate_user
    user_id = session[:user_id]
    @current_user = User.find_by(id: user_id) if user_id

    unless @current_user
      redirect_to login_path, alert: "Please log in to continue"
    end
  end
end
