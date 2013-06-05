class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_user

  def load_user
    user_id = session[:user_id]
    @current_user = user_id.nil? ? nil : User.find(user_id)
  end
end
