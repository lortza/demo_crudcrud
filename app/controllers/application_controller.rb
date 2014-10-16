class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user, :only => [:foo_action]

  private
  def authenticate_user
    # This filter will allow the user to pass if it returns true
    # and the method here passes in the username and password
    # the user provided in the login form
    authenticate_or_request_with_http_basic('Message to User') do |username, password|
      username == 'foo' && password == 'bar'
    end
  end
end
