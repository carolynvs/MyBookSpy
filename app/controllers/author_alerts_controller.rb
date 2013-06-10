class AuthorAlertsController < ApplicationController
  before_filter :authenticate_user!

  # GET /author_alerts
  # GET /author_alerts.json
  def index
    @author_alerts = AuthorAlert.where(:user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @author_alerts }
    end
  end

  # POST /author_alerts
  # POST /author_alerts.json
  def create
    author = Author.where(:name => params[:author]).first_or_create()
    @author_alert = AuthorAlert.new(:author_id => author.id, :user_id => session[:user_id])

    respond_to do |format|
      if @author_alert.save
        format.html { redirect_to(:action => 'index', :notice => "You are now following #{author.name}") }
        format.json { render json: @author_alert, status: :created, location: @author_alert }
      else
        format.html { render action: 'new' }
        format.json { render json: @author_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /author_alerts/1
  # DELETE /author_alerts/1.json
  def destroy
    @author_alert = AuthorAlert.find(params[:id])
    @author_alert.destroy

    respond_to do |format|
      format.html { redirect_to author_alerts_url }
      format.json { head :no_content }
    end
  end
end
