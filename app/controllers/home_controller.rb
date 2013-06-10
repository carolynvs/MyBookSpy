class HomeController < ApplicationController
  def index
    if user_signed_in?
      @num_author_alerts = AuthorAlert.where(:user_id => current_user.id).count()
    end
  end
end
