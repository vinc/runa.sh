class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protected

  def authenticate_user!
    if request.headers["Authorization"].present?
      authenticate_or_request_with_http_token do |token|
        return @current_user ||= User.find_by(api_key: token) # FIXME: timing attack
      end
    end
    super
  end

  def current_user
    @current_user || super
  end

  def user_signed_in?
    @current_user.present? || super
  end
end
