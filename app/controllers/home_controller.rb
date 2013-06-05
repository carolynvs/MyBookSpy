class HomeController < ApplicationController
  def index
  end

  def login
    session[:user_id] = 1
    redirect_to :action => 'index'
  end

  def logout
    session.delete(:user_id)
    redirect_to :action => 'index'
  end
end
